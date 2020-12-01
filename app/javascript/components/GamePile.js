import React from "react"
import { Droppable } from 'react-beautiful-dnd'
import PropTypes from "prop-types";

class GamePile extends React.Component {

    render () {
        return (
            <Droppable droppableId={this.props.pileId} isCombineEnable={true}>
                {(provided, snapshot) => (
                    <div ref={provided.innerRef}>
                    {/*  TODO: Create GameCard objects for each card in this pile  */}
                    </div>
                )}
            </Droppable>
        );
    }
}

GamePile.propTypes = {
    pileId: PropTypes.string
};

export default GamePile