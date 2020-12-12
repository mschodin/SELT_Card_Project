import * as React from "react";
import GamePile from "../../app/javascript/components/GamePile";
import {DragDropContext, Droppable} from "react-beautiful-dnd";
import {cleanup, render} from "@testing-library/react";

describe('Check the gamepile exists', () => {
    it('renders the gamepile', () => {
        <DragDropContext onDragEnd={() => {}}>
            <GamePile
                pileId={"pile1"}
                numId={"1"}
                roomId={"1"}
                key={"pile1"}
                pileCards={[]}
                create_deck={'create_deck'}
                isDragging={false}
                draw_multiple={'draw_multiple'}
                handId={'1'}
                deck={null}
            />
        </DragDropContext>
    })
})