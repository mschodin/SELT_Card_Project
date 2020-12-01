import React from "react"
import PropTypes from "prop-types";
import { Card, CardStyles } from 'react-casino';
import {
    DraggableItem,
    DraggableContainer,
    DroppableZone,
} from '@wuweiweiwu/react-shopify-draggable';
import '../../assets/stylesheets/application.css';
import {blue} from "@material-ui/core/colors";

class GameHand extends React.Component {



    render () {

        return (
            <React.Fragment>
                {/*<div id='player1Hand'>*/}
                {/*    <div id='card1' className='pile'>*/}
                {/*        <Card suit="D" face="9" style={{width: "75px", height: "108"}}/>*/}
                {/*    </div>*/}
                {/*    <div id='card2' className='pile'>*/}
                {/*        <Card suit="S" face="A" style={{width: "75px", height: "108"}}/>*/}
                {/*    </div>*/}
                {/*</div>*/}




                <div className="App">
                    <div className="App-body">

                        <DraggableContainer
                            as="div"
                            type="swappable"
                        >
                            <DroppableZone
                                as="div"
                                type="draggable"
                                className="pile">
                                <DraggableItem
                                    as="div"
                                    style={{backgroundColor: blue}}
                                >
                                    <Card suit="S" face="9" style={{width: "75px", height: "108"}}/>
                                </DraggableItem>
                            </DroppableZone>
                            <DroppableZone
                                as="div"
                                type="draggable"
                                className="pile">
                                <DraggableItem
                                    as="div"
                                    style={{backgroundColor: blue}}
                                >
                                    <Card suit="D" face="9" style={{width: "75px", height: "108"}}/>
                                </DraggableItem>
                            </DroppableZone>

                            <DroppableZone
                                as="div"
                                type="droppable"
                                className="pile">

                            </DroppableZone>

                        </DraggableContainer>



                    </div>
                </div>



            </React.Fragment>
        );
    }
}



GameHand.propTypes = {
    cards: PropTypes.array,
    piles: PropTypes.array
};

export default GameHand