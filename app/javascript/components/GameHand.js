import React from "react"
import {Droppable} from "react-beautiful-dnd";
import PropTypes from "prop-types";
import GameCard from "./GameCard";

class GameHand extends React.Component {

    render () {
        return (
            <Droppable droppableId={this.props.handId} direction={"horizontal"}>
                {(provided, snapshot) => (
                    <div ref={provided.innerRef}>
                        {/*  TODO: Create GameCard objects for each card in this hand  */}
                    </div>
                )}
            </Droppable>
        );
    }
}

GameHand.propTypes = {
    handId: PropTypes.string
};

export default GameHand