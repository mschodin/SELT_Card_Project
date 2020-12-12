import * as React from "react";
import GameCard from "../../app/javascript/components/GameCard";
import {DragDropContext, Droppable} from "react-beautiful-dnd";
import {cleanup, render} from "@testing-library/react";

describe('Check the card is rendered correctly', () => {
    it('renders the card as an image', () => {
        const {container, getByAltText} = render(
            <DragDropContext onDragEnd={() => {}}>
                <Droppable>
                    <GameCard face={'2'} suit={'C'} cardId={'card1'} index={1} key={'card1'}/>
                </Droppable>
            </DragDropContext>
        )

        expect(getByAltText('2C')).toBeDefined()
    })
    it('renders the card as an image', () => {
        const {container, getByAltText} = render(
            <DragDropContext onDragEnd={() => {}}>
                <Droppable>
                    <GameCard face={'A'} suit={'S'} cardId={'card1'} index={1} key={'card1'}/>
                </Droppable>
            </DragDropContext>
        )

        expect(getByAltText('AS').nodeName).toBe('IMG')
    })
})