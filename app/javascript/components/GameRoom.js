import React from "react"
import { DragDropContext } from 'react-beautiful-dnd'

class GameRoom extends React.Component {

    onDragEnd = () => {

    };

    render () {
        return (
            <DragDropContext onDragEnd={this.onDragEnd}>

            </DragDropContext>
        );
    }
}

export default GameRoom
