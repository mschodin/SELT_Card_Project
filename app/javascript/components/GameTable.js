import React from "react"
import Box from "@material-ui/core/Box";
import GameHand from "./GameHand";
import Typography from "@material-ui/core/Typography";
import GameCard from "./GameCard";
import GamePile from "./GamePile";

class GameTable extends React.Component {
    render () {
        return (
            <Box
                pb={10}
                className={"centered"}
            >
                <Box role="table" className={"tableStyle"} bgcolor={"primary.main"} boxShadow={5}>
                    {this.props.piles.map((pile, idx) =>(
                        <GamePile pileId={"pile" + pile[0]} key={"pile" + pile[0]} pileCards={pile[1]}/>
                    ))}
                </Box>
            </Box>
        );
    }
}

export default GameTable