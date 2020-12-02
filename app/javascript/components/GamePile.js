import React from "react"
import { Droppable } from 'react-beautiful-dnd'
import PropTypes from "prop-types";
import GameCard from "./GameCard";

class GamePile extends React.Component {

    render () {
        return (
            <Droppable droppableId={this.props.pileId} isCombineEnable={true}>
                {(provided, snapshot) => (
                    <div ref={provided.innerRef}>
                        {this.props.pileCards.map((card, order) => (
                            <GameCard face={card[0]} suit={card[1]} cardId={"card" + card[2]} index={order} key={"card" + card[2]}/>
                        ))}
                        {provided.placeholder}
                    </div>
                )}
            </Droppable>
        );
    }
}

GamePile.propTypes = {
    pileId: PropTypes.string,
    pileCards: PropTypes.array
};

export default GamePile