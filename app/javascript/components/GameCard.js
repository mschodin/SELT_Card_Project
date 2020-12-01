import React from "react"
import { Draggable } from 'react-beautiful-dnd'
import PropTypes from "prop-types"
import { Card } from 'react-casino'

class GameCard extends React.Component {
    render () {
        return (
            <Draggable draggableId={this.props.cardId} key={this.props.cardId} index={this.props.index}>
                {(provided, snapshot) => (
                    <div ref={provided.innerRef} {...provided.draggableProps} {...provided.dragHandleProps}>
                        <Card face={this.props.face} suit={this.props.suit} />
                    </div>
                )}
            </Draggable>
        );
    }
}

GameCard.propTypes = {
    cardId: PropTypes.string,
    index: PropTypes.number,
    face: PropTypes.string,
    suit: PropTypes.string,
};

export default GameCard