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

class GameRoom extends React.Component {
    constructor(props) {
        super(props);
        this.state = { hand: props.playerHand }
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
        }
    };

    render () {
        return (
            <ThemeProvider theme={theme}>
                <CssBaseline />
                <React.Fragment>
                    <DragDropContext onDragEnd={this.onDragEnd}>
                        <GameTable />
                        <Typography component={"div"} className={"centered"}>
                            <Box className={"handStyle"} bgcolor={"primary.main"} boxShadow={5}>
                                <GameHand handId={"hand" + this.props.handId} playerHand={this.state.hand} />
                            </Box>
                        </Typography>
                    </DragDropContext>
                </React.Fragment>
            </ThemeProvider>
        );
    }
}

GameRoom.propTypes = {
    handId: PropTypes.number,
    playerHand: PropTypes.array,
    piles: PropTypes.array
};

export default GameRoom;
