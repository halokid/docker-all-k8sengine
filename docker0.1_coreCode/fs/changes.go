package fs

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"
)

type ChangeType int

const (
	ChangeModify = iota
	ChangeAdd
	ChangeDelete
)

type Change struct {
	Path string
	Kind ChangeType
}

func (change *Change) String() string {
	var kind string
	switch change.Kind {
	case ChangeModify:
		kind = "C"
	case ChangeAdd:
		kind = "A"
	case ChangeDelete:
		kind = "D"
	}
	return fmt.Sprintf("%s %s", kind, change.Path)
}

func (store *Store) Changes(mp *Mountpoint) ([]Change, error) {
	var changes []Change
	image, err := store.Get(mp.Image)
	if err != nil {
		return nil, err
	}
	layers, err := image.layers()
	if err != nil {
		return nil, err
	}

	err = filepath.Walk(mp.Rw, func(path string, f os.FileInfo, err error) error {
		if err != nil {
			return err
		}

		// Rebase path
		path, err = filepath.Rel(mp.Rw, path)
		if err != nil {
			return err
		}
		path = filepath.Join("/", path)

		// Skip root
		if path == "/" {
			return nil
		}

		// Skip AUFS metadata
		if matched, err := filepath.Match("/.wh..wh.*", path); err != nil || matched {
			return err
		}

		change := Change{
			Path: path,
		}

		// Find out what kind of modification happened
		file := filepath.Base(path)
		// If there is a whiteout, then the file was removed
		if strings.HasPrefix(file, ".wh.") {
			originalFile := strings.TrimLeft(file, ".wh.")
			change.Path = filepath.Join(filepath.Dir(path), originalFile)
			change.Kind = ChangeDelete
		} else {
			// Otherwise, the file was added
			change.Kind = ChangeAdd

			// ...Unless it already existed in a top layer, in which case, it's a modification
			for _, layer := range layers {
				stat, err := os.Stat(filepath.Join(layer, path))
				if err != nil && !os.IsNotExist(err) {
					return err
				}
				if err == nil {
					// The file existed in the top layer, so that's a modification

					// However, if it's a directory, maybe it wasn't actually modified.
					// If you modify /foo/bar/baz, then /foo will be part of the changed files only because it's the parent of bar
					if stat.IsDir() && f.IsDir() {
						if f.Size() == stat.Size() && f.Mode() == stat.Mode() && f.ModTime() == stat.ModTime() {
							// Both directories are the same, don't record the change
							return nil
						}
					}
					change.Kind = ChangeModify
					break
				}
			}
		}

		// Record change
		changes = append(changes, change)
		return nil
	})
	if err != nil {
		return nil, err
	}
	return changes, nil
}

// Reset removes all changes to the filesystem, reverting it to its initial state.
func (mp *Mountpoint) Reset() error {
	if err := os.RemoveAll(mp.Rw); err != nil {
		return err
	}
	// We removed the RW directory itself along with its content: let's re-create an empty one.
	if err := mp.createFolders(); err != nil {
		return err
	}
	return nil
}
