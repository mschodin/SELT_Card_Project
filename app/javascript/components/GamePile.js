import React, { useState } from "react"
import { Droppable } from 'react-beautiful-dnd'
import PropTypes from "prop-types";
import GameCard from "./GameCard";
import Box from "@material-ui/core/Box";
import Popover from '@material-ui/core/Popover';
import {Typography} from "@material-ui/core";

class GamePile extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            hidden : true,
            showInfo: false,
            anchorEl: null,
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

    // setShowInfo = (val) => {
    //     this.setState({
    //         showInfo: val,
    //     })
    // }
    handlePopoverOpen = (event) => {
        console.log("im in here!")
        this.setState({
            showInfo: true,
            anchorEl: event.currentTarget,
        })
    }

    handlePopoverClose = () => {
        console.log("im HEEER!")
        this.setState({
            showInfo: false,
            anchorEl: null,
        })
    }

    render () {
        let first_card = this.props.pileCards[0]
        return (
            <React.Fragment>
                <div>
                    <Box role="pile" className={"pileStyle"} variant={"outlined"} boxShadow={5} >
                        <Droppable droppableId={this.props.pileId} isCombineEnabled key={this.props.pileId} direction="horizontal" >
                            {(provided, snapshot) => (
                                <div ref={provided.innerRef} onMouseEnter={() => this.handlePopoverOpen} onMouseLeave={() => this.handlePopoverClose}>
                                    {Array.isArray(first_card) && <GameCard hidden={this.state.hidden} face={first_card[0]} suit={first_card[1]} cardId={"card" + first_card[2]} index={0} key={"card" + first_card[2]}/>}
                                    {provided.placeholder}
                                </div>
                            )}
                        </Droppable>
                    </Box>
                    {/*{this.state.showInfo && (*/}
                    {/*<Popover*/}
                    {/*    id="mouse-over-popover"*/}
                    {/*    // className={classes.popover}*/}
                    {/*    // classes={{*/}
                    {/*    //     paper: classes.paper,*/}
                    {/*    // }}*/}
                    {/*    open={this.state.showInfo}*/}
                    {/*    anchorEl={this.state.anchorEl}*/}
                    {/*    anchorOrigin={{*/}
                    {/*        vertical: 'bottom',*/}
                    {/*        horizontal: 'left',*/}
                    {/*    }}*/}
                    {/*    transformOrigin={{*/}
                    {/*        vertical: 'top',*/}
                    {/*        horizontal: 'left',*/}
                    {/*    }}*/}
                    {/*    onClose={this.handlePopoverClose}*/}
                    {/*    disableRestoreFocus*/}
                    {/*>*/}
                    {/*    <Typography>*/}
                    {/*        TEST TEXT*/}
                    {/*    </Typography>*/}
                    {/*</Popover>*/}
                    {/*)}*/}
                </div>
            </React.Fragment>
        );
    }
}

GamePile.propTypes = {
    pileId: PropTypes.string,
    // pileCards: PropTypes.array
};

export default GamePile