import * as React from "react";
import {cleanup, render} from "@testing-library/react";
import GameHand from "../../app/javascript/components/GameHand";
import {DragDropContext} from "react-beautiful-dnd";

afterEach(cleanup);

describe('Check the GameHand is displayed when entering a room', () => {
    it('renders GameHand in the GameRoom', () => {
        const {container, getByText} = render(
            <DragDropContext onDragEnd={() => {}}>
                <GameHand handId={"hand1"} playerHand={[]}/>
            </DragDropContext>
        )

        expect(container.firstChild.className).toBe('handDrop')
    })
    it('contains a card when given card properties', () => {
        const {container, getByAltText} = render(
            <DragDropContext onDragEnd={() => {}}>
                <GameHand handId={"hand1"} playerHand={[['5', 'C', '1'], ['9', 'D', '2']]}/>
            </DragDropContext>
        )

        expect(getByAltText('5C')).toBeDefined()
        expect(getByAltText('9D')).toBeDefined()
        expect(getByAltText('5C').nodeName).toBe('IMG')
        expect(getByAltText('9D').nodeName).toBe('IMG')
    })
})