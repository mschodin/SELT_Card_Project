import React from "react";
import { DragDropContext } from 'react-beautiful-dnd';
import GameTable from './GameTable';
import GameHand from './GameHand';
import PropTypes from "prop-types";
import '../../assets/stylesheets/room.css';
import Box from '@material-ui/core/Box';
import Typography from "@material-ui/core/Typography";
import { ThemeProvider } from "@material-ui/core/styles";
import CssBaseline from "@material-ui/core/CssBaseline";
import theme from '../styles/theme'
import PlayerList from "./PlayerList";

class GameRoom extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            hand: props.playerHand,
            piles: {}
        }
        this.props.piles.forEach(pile => this.state.piles[pile[0]]=pile[1])
    }

    onDragEnd = (result) => {
        if(result.destination != null) {
            if(result.source.droppableId === result.destination.droppableId && result.destination.droppableId.includes('hand')){
                const reorderedHand = Array.from(this.state.hand);
                const [removed] = reorderedHand.splice(result.source.index, 1);
                reorderedHand.splice(result.destination.index, 0, removed);
                this.setState({
                    hand: reorderedHand
                })
            }
            else if(result.source.droppableId.includes('hand') && result.destination.droppableId.includes('pile')){
                console.log("discard");
                const reorderedHand = Array.from(this.state.hand);
                const pile_id = result.destination.droppableId.split("pile")[1]
                const [removed] = reorderedHand.splice(result.source.index, 1);
                this.state.piles[pile_id].splice(0, 0, removed);
                this.setState({
                    hand: reorderedHand,
                })            }
            else if(result.source.droppableId.includes('pile') && result.destination.droppableId.includes('hand')){
                console.log("draw card");
                const reorderedHand = Array.from(this.state.hand);
                const pile_id = result.source.droppableId.split("pile")[1]
                const [draw] = this.state.piles[pile_id].splice(0, 1)
                reorderedHand.splice(result.destination.index, 0, draw);
                this.setState({
                    hand: reorderedHand,
                })
            }
            else if(result.source.droppableId !== result.destination.droppableId && result.source.droppableId.includes('pile') && result.destination.droppableId.includes('pile')){
                console.log("move card between pile");
                console.log(result)//
            }
        }
    };

    render () {
        return (
            <ThemeProvider theme={theme}>
                <CssBaseline />
                <React.Fragment>
                    <Box className={'room'}>
                        <PlayerList players={this.props.players}/>
                        <DragDropContext onDragEnd={this.onDragEnd}>
                            <GameTable piles={this.props.piles}/>
                            <Typography component={"div"} className={"centered"}>
                                <Box className={"handStyle"} bgcolor={"primary.main"} boxShadow={5}>
                                    <GameHand handId={"hand" + this.props.handId} playerHand={this.state.hand} />
                                </Box>
                            </Typography>
                        </DragDropContext>
                    </Box>
                </React.Fragment>
            </ThemeProvider>
        );
    }
}

GameRoom.propTypes = {
    handId: PropTypes.number,
    playerHand: PropTypes.array,
    piles: PropTypes.array,
    players: PropTypes.object

};

export default GameRoom;
