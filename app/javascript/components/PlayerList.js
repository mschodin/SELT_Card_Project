import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import List from '@material-ui/core/List';
import ListItem from '@material-ui/core/ListItem';
import ListItemIcon from '@material-ui/core/ListItemIcon';
import ListItemText from '@material-ui/core/ListItemText';
import Divider from '@material-ui/core/Divider';
import InboxIcon from '@material-ui/icons/Inbox';
import DraftsIcon from '@material-ui/icons/Drafts';
import {PersonOutline} from "@material-ui/icons";

const useStyles = makeStyles((theme) => ({
    root: {
        width: '100%',
        maxWidth: 360,
        backgroundColor: 'floralwhite',
    },
}));

function ListPlayers(props) {
    const players = props.players;
    const listItems = Object.entries(players).map(([name,count])=>
        <ListItem className="listItemStyle" key={count}>
            <ListItemIcon key={count}>
                <PersonOutline key={count} />
            </ListItemIcon>
            <ListItemText primary= {name.toString() + ": " + count.toString() + " card(s)"} />
        </ListItem>
    );
    return <ul>{listItems}</ul>;
}

export default function PlayerList(props) {
    const classes = useStyles();

    return (
        <div className="multiListStyle">
            <List className="listStyle" component="nav" aria-label="main list players">
                <ListPlayers players={props.players}/>
            </List>
        </div>
    );
}