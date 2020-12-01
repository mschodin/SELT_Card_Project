import React from "react"
import PropTypes from "prop-types";
import { Card, CardStyles } from 'react-casino';
import {Droppable, Draggable} from 'react-beautiful-dnd';
import '../../assets/stylesheets/application.css';

class NewHand extends React.Component {

    render () {

        return (
            <Droppable droppableId={"drop1"}>
                {(provided, snapshot) => (
                    <div ref={provided.innerRef} style={{ backgroundColor: snapshot.isDraggingOver ? 'blue' : 'grey' }}
                         {...provided.droppableProps}>
                        <div>
                            <Draggable draggableId={'drag1'} index={0}>
                                {(provided, snapshot) => (
                                    <div ref={provided.innerRef}
                                        {...provided.draggableProps}
                                        {...provided.dragHandleProps}>
                                        <Card suit="D" face="9" style={{width: "75px", height: "108"}}/>
                                    </div>
                                )}
                            </Draggable>
                            {provided.placeholder}
                        </div>
                        {/*<Draggable draggableId={'drag2'} index={1}>*/}
                        {/*    <Card suit="S" face="A" style={{width: "75px", height: "108"}}/>*/}
                        {/*</Draggable>*/}
                    </div>
                )}
            </Droppable>

            // <Droppable droppableId="drop1">
            //     <Draggable draggableId={'drag1'} index={0}>
            //         <Card suit="D" face="9" style={{width: "75px", height: "108"}}/>
            //     </Draggable>
            //     <Draggable draggableId={'drag2'} index={1}>
            //         <Card suit="S" face="A" style={{width: "75px", height: "108"}}/>
            //     </Draggable>
            // </Droppable>
        );
    }
}



NewHand.propTypes = {
    cards: PropTypes.array,
    piles: PropTypes.array
};

export default NewHand;