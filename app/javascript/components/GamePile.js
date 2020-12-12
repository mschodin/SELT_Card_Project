import React, { useState } from "react"
import { Droppable } from 'react-beautiful-dnd'
import PropTypes from "prop-types";
import GameCard from "./GameCard";
import Box from "@material-ui/core/Box";
import Popover from '@material-ui/core/Popover';
import { Typography, ButtonGroup, Button } from "@material-ui/core";
import theme from "../styles/theme";
import {ThemeProvider} from "@material-ui/core/styles";
import {AddBoxOutlined} from "@material-ui/icons";
import IconButton from "@material-ui/core/IconButton";
import withStyles from "@material-ui/core/styles/withStyles";

const styles = theme => ({
    popover: {
        pointerEvents: 'none',
    },
    paper: {
        padding: theme.spacing(1),
    },
});

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
        this.handleAddDeck = this.handleAddDeck.bind(this);
    }

    componentDidMount() {
        //if not a deck, set hidden to false (set to face-up)
        if (this.props.deck.length === 0) {
            this.setState({
                hidden: false
            });
        }
    }

    async handleAddDeck(e){
        const url = this.props.create_deck
        console.log(url)
        console.log(this.props.numId)
        console.log(this.props.roomId)//
        const body = JSON.stringify({
            room_id: this.props.roomId,
            pile_id: this.props.numId
        })

        if (this.props.pileCards.length === 0){
            fetch(url,{
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'text/html, application/json, application/xhtml+xml, application/xml'
                },
                body: body,
            }).then((response) => {
                console.log(response);
                window.location.reload(true)
            })
        }
    }

    handlePopoverOpen = (event) => {
        if(this.state.showMenu === false && this.props.pileCards.length > 0){
            this.setState({
                showInfo: true,
                anchorEl: event.currentTarget,
            })
        }
    }

    handlePopoverClose = () => {
        if(this.state.showMenu === false && this.props.pileCards.length > 0){
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
        if(this.props.pileCards.length > 0) {
            this.setState({
                showInfo: false,
                showMenu: true,
                anchorEl: event.currentTarget,
           })
        }
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
        let body = JSON.stringify({
            count: this.state.quantity,
            room_id: this.props.roomId,
            pile_id: this.props.pileId,
            hand_id: this.props.handId,
        })
        fetch(this.props.draw_multiple, {
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
        const {classes} = this.props;
        let first_card = this.props.pileCards[0]
        return (
            <ThemeProvider theme={theme}>
                <div>
                    <Box role="pile" className={"pileStyle"} variant={"outlined"} boxShadow={5} >
                        <Droppable droppableId={this.props.pileId} isCombineEnabled key={this.props.pileId} direction="horizontal" >
                            {(provided, snapshot) => (
                                <div ref={provided.innerRef} onMouseEnter={this.handlePopoverOpen} onMouseLeave={this.handlePopoverClose} aria-haspopup={true} onClick={this.openDrawMenu}>
                                    {Array.isArray(first_card)
                                        ? <GameCard hidden={this.state.hidden} face={first_card[0]} suit={first_card[1]} cardId={"card" + first_card[2]} index={0} key={"card" + first_card[2]}/>
                                        : !this.props.isDragging && <IconButton
                                        aria-owns={Boolean(this.state.anchorEl) ? 'mouse-over-popover' : undefined}
                                        aria-haspopup={"true"}
                                        onClick={this.handleAddDeck}
                                        onMouseEnter={(e) => {
                                            if(this.props.pileCards.length === 0) {
                                                this.setState({
                                                    hover: true,
                                                    anchorEl: e.currentTarget
                                                })
                                            }
                                        }}
                                        onMouseLeave={() => {
                                            if(this.props.pileCards.length === 0) {
                                                this.setState({
                                                    hover: false,
                                                    anchorEl: null
                                                })
                                            }
                                        }}
                                    ><AddBoxOutlined/></IconButton>
                                    }
                                    {provided.placeholder}
                                </div>
                            )}
                        </Droppable>
                        <Popover
                            id="mouse-over-popover"
                            open={Boolean(this.state.anchorEl) && this.props.pileCards.length === 0}
                            className={classes.popover}
                            classes={{
                                paper: classes.paper,
                            }}
                            anchorEl={this.state.anchorEl}
                            anchorOrigin={{
                                vertical: 'top',
                                horizontal: 'right',
                            }}
                            transformOrigin={{
                                vertical: 'bottom',
                                horizontal: 'left',
                            }}
                            disableRestoreFocus
                        >
                            <Typography>Add Deck</Typography>
                        </Popover>
                    </Box>
                    <Popover
                        id="mouse-over-popover"
                        classes={{
                            paper: classes.paper,
                        }}
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
                        classes={{
                            paper: classes.paper,
                        }}
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
                            <div style={{justifyContent: 'center', alignContent: 'center', display: 'flex', padding: '5%'}}>
                                <Typography>
                                    Cards in Deck: {this.props.pileCards.length}
                                </Typography>
                            </div>
                            <div style={{justifyContent: 'center', alignContent: 'center', display: 'flex'}}>
                                <ButtonGroup>
                                    <Button onClick={this.handleDecrement}>-</Button>
                                    <Button disabled style={{color: "black"}}>{this.state.quantity}</Button>
                                    <Button onClick={this.handleIncrement}>+</Button>
                                </ButtonGroup>
                            </div>
                            <div style={{justifyContent: 'center', alignContent: 'center', padding: '5%', display: 'flex'}}>
                                <Button variant="contained" color={"primary"} onClick={this.submitDraw} style={{width: '40%', justifyContent: 'center', alignContent: 'center', marginRight: '10px'}}>Confirm</Button>
                                <Button variant="contained" color={"secondary"} onClick={this.closeDrawMenu} style={{width: '40%', justifyContent: 'center', marginLeft: '10px'}}>Cancel</Button>
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
    numId: PropTypes.number,
    roomId: PropTypes.number,
    isDragging: PropTypes.bool,
    draw_multiple: PropTypes.string
    // pileCards: PropTypes.array
};

export default withStyles(styles(theme))(GamePile)