import React from "react"
import { Droppable } from 'react-beautiful-dnd'
import PropTypes from "prop-types";
import GameCard from "./GameCard";
import Box from "@material-ui/core/Box";

class GamePile extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            hidden : true,
        }
    }

    componentDidMount() {
        // console.log(this.props.pileCards.isEmpty())
        if (this.props.pileCards.length == 0) {
            this.setState({
                hidden: false
            });
        }

    }

    render () {
        // console.log(this.props.pileId)
        // console.log(this.props.pileCards)
        let first_card = this.props.pileCards[0]
        // console.log(first_card)
        return (
            <Box className={"pileStyle"} variant={"outlined"} boxShadow={5}>
                <Droppable droppableId={this.props.pileId} isCombineEnabled key={this.props.pileId} direction="horizontal">
                    {(provided, snapshot) => (
                        <div ref={provided.innerRef}>
                            {/*{this.props.pileCards.map((card, order) => (*/}
                            {/*    <GameCard face={card[0]} suit={card[1]} cardId={"card" + card[2]} index={order} key={"card" + card[2]}/>*/}
                            {/*))}*/}
                            {Array.isArray(first_card) && <GameCard hidden={this.state.hidden} face={first_card[0]} suit={first_card[1]} cardId={"card" + first_card[2]} index={0} key={"card" + first_card[2]}/>}
                            {provided.placeholder}
                        </div>
                    )}
                </Droppable>
            </Box>

        );
    }
}

GamePile.propTypes = {
    pileId: PropTypes.string,
    // pileCards: PropTypes.array
};

export default GamePile