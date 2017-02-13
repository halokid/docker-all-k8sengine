"use strict";
import {getTimelineItemModel}  from "./data_access/modelFactory";
import timelineItems           from "./data/timelineItems-seed";

export const initialize = async() => {
    try {
        await seedTimelineEvents();
    } catch (err) {
        throw err;
    }
};

const seedTimelineEvents = async() => {

    //don't hardcode creds - this is simply for the demo
    const creds = {
        "user": "modify",
        "pass": "dontgiveintothehate"
    };

    const TimelineItem = await getTimelineItemModel(creds);
    const timelineItemsExists = await TimelineItem.count({});

    try {
        if (!timelineItemsExists) {
            let timelineItemModels = timelineItems.map(function (i) {
                i.details = i.details.split("\n\n");
                return new TimelineItem(i);
            });

            await TimelineItem.insertMany(timelineItemModels);
        }
    } catch (err) {
        throw err;
    }
};