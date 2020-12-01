import React from "react"
import {Droppable} from "react-beautiful-dnd"
import PropTypes from "prop-types"
import GameCard from './GameCard'

class GameHand extends React.Component {

    render () {
        console.log(this.props.playerHand)
        return (
            <Droppable droppableId={this.props.handId} direction={"horizontal"}>
                {(provided, snapshot) => (
                    <div ref={provided.innerRef}>
                        {this.props.playerHand.map((card, order) => (
                            <GameCard face={card[0]} suit={card[1]} cardId={"card" + card[2]} index={order} key={"card" + card[2]}/>
                        ))}
                    </div>
                )}
            </Droppable>
        );
    }
}

GameHand.propTypes = {
    handId: PropTypes.string,
    playerHand: PropTypes.array
};

export default GameHand