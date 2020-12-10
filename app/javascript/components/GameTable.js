import React from "react"
import Box from "@material-ui/core/Box";
import GameHand from "./GameHand";
import Typography from "@material-ui/core/Typography";
import GameCard from "./GameCard";
import GamePile from "./GamePile";
import PropTypes from "prop-types";

class GameTable extends React.Component {

    render () {
        return (
            <Box
                pb={10}
                className={"centered"}
            >
                <Box role="table" className={"tableStyle"} bgcolor={"primary.main"} boxShadow={5}>
                    {this.props.piles.map((pile, idx) =>(
                        <GamePile
                            pileId={"pile" + pile[0]}
                            numId={pile[0]}
                            roomId={this.props.roomId}
                            key={"pile" + pile[0]}
                            pileCards={pile[1]}
                            create_deck={this.props.create_deck.replace("__pile_id__", pile[0])}
                            isDragging={this.props.isDragging}
                        />
                    ))}
                </Box>
            </Box>
        );
    }
}

GameTable.propTypes = {
    numId: PropTypes.number,
    roomId: PropTypes.number,
    isDragging: PropTypes.bool
    // pileCards: PropTypes.array
};
export default GameTable