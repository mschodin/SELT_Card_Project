import React from "react"
import { Draggable } from 'react-beautiful-dnd'
import PropTypes from "prop-types"
import { Card } from 'react-casino'

const cardStyle = (draggableStyle) => ({
    padding: '2px',
    height: '108px',
    width: '75px',
    display: 'inline-block',
    ...draggableStyle,
});

class GameCard extends React.Component {

    render () {
        return (
            <Draggable draggableId={this.props.cardId} key={this.props.cardId} index={this.props.index} >
                {(provided, snapshot) => (
                    <div ref={provided.innerRef} {...provided.draggableProps} {...provided.dragHandleProps} style={cardStyle(
                        provided.draggableProps.style
                    )}>
                        <Card face={this.props.face} suit={this.props.suit} style={{width: "75px", height: "108px", display: 'inline-block', padding: '2px'}} />
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