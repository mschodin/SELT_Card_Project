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
import Grid from "@material-ui/core/Grid";
import RoomAppBar from "./RoomAppBar";

class GameRoom extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            hand: props.playerHand,
            piles: {},
            isDragging: false
        }
        this.props.piles.forEach(pile => this.state.piles[pile[0]]=pile[1])
    }

    handleDragStart = () =>{
        this.setState({
            isDragging: true
        })
    }

    onDragEnd = (result) => {
        this.setState({
            isDragging: false
        })
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
                })
                const card_id = result.draggableId.split("card")[1]
                const body = JSON.stringify( {
                    room_id: this.props.room_id,
                    card_id: card_id,
                    pile_id: pile_id
                })
                const url = window.location.href + "/card/" + card_id
                fetch(url, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'text/html, application/json, application/xhtml+xml, application/xml'
                    },
                    body: body,
                }).then((response) => {console.log(response)})
            }
            else if(result.source.droppableId.includes('pile') && result.destination.droppableId.includes('hand')){
                console.log("draw card");
                console.log(result)
                const reorderedHand = Array.from(this.state.hand);
                const pile_id = result.source.droppableId.split("pile")[1]
                const [draw] = this.state.piles[pile_id].splice(0, 1)
                reorderedHand.splice(result.destination.index, 0, draw);
                this.setState({
                    hand: reorderedHand,
                })
                const hand_id = result.destination.droppableId.split("hand")[1]
                const card_id = result.draggableId.split("card")[1]
                const body = JSON.stringify( {
                    room_id: this.props.room_id,
                    card_id: card_id,
                    hand_id: hand_id
                })
                const url = window.location.href + "/card/" + card_id
                console.log(url)
                fetch(url, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'text/html, application/json, application/xhtml+xml, application/xml'
                    },
                    body: body,
                }).then((response) => {console.log(response)})
            }
            else if(result.source.droppableId !== result.destination.droppableId && result.source.droppableId.includes('pile') && result.destination.droppableId.includes('pile')){
                console.log("move card between pile");
                console.log(result)
                const source_pile_id = result.source.droppableId.split("pile")[1]
                const destination_pile_id = result.destination.droppableId.split("pile")[1]
                const [removed] = this.state.piles[source_pile_id].splice(0, 1)
                this.state.piles[destination_pile_id].splice(0, 0, removed);
                const card_id = result.draggableId.split("card")[1]
                const body = JSON.stringify( {
                    room_id: this.props.room_id,
                    card_id: card_id,
                    pile_id: destination_pile_id
                })
                const url = window.location.href + "/card/" + card_id
                console.log(url)
                fetch(url, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'text/html, application/json, application/xhtml+xml, application/xml'
                    },
                    body: body,
                }).then((response) => {console.log(response)})
            }
        }
    };

    render () {
        console.log(this.props.piles_to_deck)
        return (
            <ThemeProvider theme={theme}>
                <CssBaseline/>
                <React.Fragment>
                    <RoomAppBar
                        room_id={this.props.roomId}
                        greeting={`Welcome, ${this.props.player["name"]} to room #${this.props.roomId}`}
                        room_passcode={this.props.room_passcode}
                    />
                    <div className={"appbar_spacing"}/>
                    <Box className={'room'}>
                        <DragDropContext onDragEnd={this.onDragEnd} onDragStart={this.handleDragStart}>
                            <Grid container spacing={3}>
                                <Grid item xs={2}><PlayerList players={this.props.players}/></Grid>
                                <Grid item xs={8}>
                                  <GameTable
                                      piles={this.props.piles}
                                      create_deck={this.props.create_deck_urls}
                                      roomId={this.props.roomId}
                                      isDragging={this.state.isDragging}
                                      draw_multiple={this.props.draw_multiple}
                                      handId={this.props.handId}
                                      pilesToDeck={this.props.piles_to_deck}
                                  />
                                </Grid>
                                <Grid item xs={2}/>
                            </Grid>
                            <div className={"centered"}>
                                <Box className={"handStyle"} bgcolor={"primary.main"} boxShadow={5}>
                                    <GameHand handId={"hand" + this.props.handId} playerHand={this.state.hand} />
                                </Box>
                            </div>
                        </DragDropContext>
                    </Box>
                </React.Fragment>
            </ThemeProvider>
        );
    }
}

GameRoom.propTypes = {
    roomId: PropTypes.number,
    handId: PropTypes.number,
    playerHand: PropTypes.array,
    piles: PropTypes.array,
    players: PropTypes.object

};

export default GameRoom;
