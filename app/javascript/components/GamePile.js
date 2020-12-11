import React, { useState } from "react"
import { Droppable } from 'react-beautiful-dnd'
import PropTypes from "prop-types";
import GameCard from "./GameCard";
import Box from "@material-ui/core/Box";
import Popover from '@material-ui/core/Popover';
import { Typography, ButtonGroup, Button, Dialog } from "@material-ui/core";
import theme from "../styles/theme";
import {ThemeProvider} from "@material-ui/core/styles";

class GamePile extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            hidden : true,
            showInfo: false,
            anchorEl: null,
            showMenu: false,
            quantity: 0,
        }
    }

    componentDidMount() {
        if (this.props.pileCards.length == 0) {
            this.setState({
                hidden: false
            });
        }

    }

    handlePopoverOpen = (event) => {
        if(this.state.showMenu === false){
            this.setState({
                showInfo: true,
                anchorEl: event.currentTarget,
            })
        }
    }

    handlePopoverClose = () => {
        if(this.state.showMenu === false){
            this.setState({
                showInfo: false,
                anchorEl: null,
            })
        }
    }

    handleIncrement = () => {
        if(this.state.quantity < this.props.pileCards.length){
            this.setState({
                quantity: this.state.quantity+1,
            })
        }
    }

    handleDecrement = () => {
        if(this.state.quantity > 0){
            this.setState({
                quantity: this.state.quantity-1,
            })
        }
    }

    openDrawMenu = (event) => {
        this.setState({
            showInfo: false,
            showMenu: true,
            anchorEl: event.currentTarget,
       })
    }

    closeDrawMenu = () => {
        this.setState({
            showMenu: false,
            anchorEl: null,
            quantity: 0,
        })
    }

    submitDraw = (event) => {
        event.preventDefault();
        console.log(this.props.deckId)
        let body = JSON.stringify({count: this.state.quantity})
        let url = this.props.draw_multiple.replace("DECK", this.props.deckId)
        fetch(url, {
            method: 'post',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'text/html, application/json, application/xhtml+xml, application/xml'
            },
            body: body,
        }).then((response) => {
            this.closeDrawMenu();
        })
    }

    render () {
        let first_card = this.props.pileCards[0]
        return (
            <ThemeProvider theme={theme}>
                <div>
                    <Box role="pile" className={"pileStyle"} variant={"outlined"} boxShadow={5} >
                        <Droppable droppableId={this.props.pileId} isCombineEnabled key={this.props.pileId} direction="horizontal" >
                            {(provided, snapshot) => (
                                <div ref={provided.innerRef} onMouseEnter={this.handlePopoverOpen} onMouseLeave={this.handlePopoverClose} aria-haspopup={true} onClick={this.openDrawMenu}>
                                    {Array.isArray(first_card) && <GameCard hidden={this.state.hidden} face={first_card[0]} suit={first_card[1]} cardId={"card" + first_card[2]} index={0} key={"card" + first_card[2]}/>}
                                    {provided.placeholder}
                                </div>
                            )}
                        </Droppable>
                    </Box>
                    <Popover
                        id="mouse-over-popover"
                        style={{pointerEvents: 'none', padding: 100}}
                        open={this.state.showInfo}
                        anchorEl={this.state.anchorEl}
                        anchorOrigin={{
                            vertical: 'bottom',
                            horizontal: 'left',
                        }}
                        transformOrigin={{
                            vertical: 'top',
                            horizontal: 'left',
                        }}
                        onClose={this.handlePopoverClose}
                        disableRestoreFocus
                    >
                        <div>
                            <Typography>
                                Cards in Deck: {this.props.pileCards.length}
                            </Typography>
                            <Typography>
                                Click on deck to draw multiple cards
                            </Typography>
                        </div>
                    </Popover>
                    <Popover
                        id="mouse-click-popover"
                        open={this.state.showMenu}
                        anchorEl={this.state.anchorEl}
                        anchorOrigin={{
                            vertical: 'bottom',
                            horizontal: 'left',
                        }}
                        transformOrigin={{
                            vertical: 'top',
                            horizontal: 'left',
                        }}
                    >
                        <div style={{width: '200px'}}>
                            <div style={{justifyContent: 'center', alignContent: 'center', display: 'flex'}}>
                                <Typography>
                                    Cards in Deck: {this.props.pileCards.length}
                                </Typography>
                            </div>
                            <div style={{justifyContent: 'center', alignContent: 'center', display: 'flex'}}>
                                <ButtonGroup>
                                    <Button onClick={this.handleDecrement}>-</Button>
                                    <Button disabled>{this.state.quantity}</Button>
                                    <Button onClick={this.handleIncrement}>+</Button>
                                </ButtonGroup>
                            </div>
                            <div>
                                <Button onClick={this.submitDraw} style={{width: '50%'}}>Confirm</Button>
                                <Button onClick={this.closeDrawMenu} style={{width: '50%'}}>Cancel</Button>
                            </div>
                        </div>
                    </Popover>
                </div>
            </ThemeProvider>
        );
    }
}

GamePile.propTypes = {
    pileId: PropTypes.string,
    // pileCards: PropTypes.array
};

export default GamePile