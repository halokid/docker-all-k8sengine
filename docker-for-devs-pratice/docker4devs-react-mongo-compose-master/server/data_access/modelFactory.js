"use strict";

import {TimelineItemSchema}         from "./schemas";
import connectionProvider           from "./connectionProvider";
import {serverSettings}             from "../settings";
//
// const creds = {
//     "user": "app_role",
//     "pass": "temppass"
// };

export const getTimelineItemModel = async function (creds) {
    try {
        const conn = await connectionProvider(serverSettings.serverUrl, serverSettings.database, creds);
        return conn.model("TimelineItem", TimelineItemSchema);
    } catch (err) {
        throw err;
    }
};