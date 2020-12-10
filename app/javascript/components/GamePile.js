import React from "react"
import { Droppable } from 'react-beautiful-dnd'
import PropTypes from "prop-types";
import GameCard from "./GameCard";
import Box from "@material-ui/core/Box";
import Popover from "@material-ui/core/Popover";
import {Typography} from "@material-ui/core";
import Button from "@material-ui/core/Button";
import {AddBoxOutlined} from "@material-ui/icons";
import IconButton from "@material-ui/core/IconButton";
import withStyles from "@material-ui/core/styles/withStyles";
import theme from "../styles/theme";

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
            hover: false,
            hidden : true,
            anchorEl : null,
        }
        this.handleAddDeck = this.handleAddDeck.bind(this);
    }

    componentDidMount() {
        if (this.props.pileCards.length == 0) {
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

        if (this.props.pileCards.length == 0){
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

    render () {
        const {classes} = this.props;
        let first_card = this.props.pileCards[0]
        return (
            <Box
                className={"pileStyle"}
                variant={"outlined"}
                boxShadow={5}
            >
                <Droppable droppableId={this.props.pileId} isCombineEnabled key={this.props.pileId} direction="horizontal">
                    {(provided, snapshot) => (
                        <div ref={provided.innerRef}>
                            {Array.isArray(first_card)
                                ? <GameCard hidden={this.state.hidden} face={first_card[0]} suit={first_card[1]} cardId={"card" + first_card[2]} index={0} key={"card" + first_card[2]}/>
                                :   !this.props.isDragging && <IconButton
                                    aria-owns={Boolean(this.state.anchorEl) ? 'mouse-over-popover' : undefined}
                                    aria-haspopup={"true"}
                                    onClick={this.handleAddDeck}
                                    onMouseEnter={(e) => this.setState({
                                        hover: true,
                                        anchorEl: e.currentTarget
                                    })}
                                    onMouseLeave={() => this.setState({
                                        hover: false,
                                        anchorEl: null
                                    })}
                                ><AddBoxOutlined/></IconButton>
                        }
                            {provided.placeholder}
                        </div>
                    )}
                </Droppable>
                <Popover
                    id="mouse-over-popover"
                    open={Boolean(this.state.anchorEl)}
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

        );
    }
}

GamePile.propTypes = {
    pileId: PropTypes.string,
    numId: PropTypes.number,
    roomId: PropTypes.number,
    isDragging: PropTypes.bool
    // pileCards: PropTypes.array
};

export default withStyles(styles(theme))(GamePile)