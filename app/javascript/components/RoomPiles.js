import React from "react"
import PropTypes from "prop-types";
import { Card, CardStyles } from 'react-casino';
import '../../assets/stylesheets/application.css';
import {DragDropContext} from 'react-beautiful-dnd';
import NewHand from './NewHand.js';

class RoomPiles extends React.Component {

    onDragEnd = () => {
        // the only one that is required
    };

    render () {
        return (
            <DragDropContext onDragEnd={this.onDragEnd}>
                <NewHand />
                <NewHand />
            </DragDropContext>
        );
    }
}

RoomPiles.propTypes = {
    cards: PropTypes.array,
    piles: PropTypes.array
};

export default RoomPiles;