import React from "react"
import { DragDropContext } from 'react-beautiful-dnd'
import GameTable from './GameTable'
import GameHand from './GameHand'
import PropTypes from "prop-types"

class GameRoom extends React.Component {

    onDragEnd = () => {

    };

    render () {
        console.log(this.props.piles)
        return (
            <DragDropContext onDragEnd={this.onDragEnd}>
                <GameTable />
                <GameHand handId={"hand" + this.props.handId} playerHand={this.props.playerHand} />
            </DragDropContext>
        );
    }
}

GameRoom.propTypes = {
    handId: PropTypes.number,
    playerHand: PropTypes.array,
    piles: PropTypes.array
};

export default GameRoom
