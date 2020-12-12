import * as React from "react";
import GamePile from "../../app/javascript/components/GamePile";
import {DragDropContext} from "react-beautiful-dnd";
import {cleanup, render} from "@testing-library/react";

afterEach(cleanup);

describe('Check the gamepile exists', () => {
    it('renders the gamepile', () => {
        const {container, getByRole} = render (
            <DragDropContext onDragEnd={() => {}}>
                <GamePile
                    pileId={"pile1"}
                    numId={1}
                    roomId={1}
                    key={"pile1"}
                    pileCards={[]}
                    create_deck={'create_deck'}
                    isDragging={false}
                    draw_multiple={'draw_multiple'}
                    handId={'1'}
                    deck={[]}
                />
            </DragDropContext>
        )

        expect(getByRole('pile')).toBeDefined()
    })
    it('renders a card in the pile', () => {
        const {container, getByAltText} = render (
            <DragDropContext onDragEnd={() => {}}>
                <GamePile
                    pileId={"pile1"}
                    numId={1}
                    roomId={1}
                    key={"pile1"}
                    pileCards={[['5', 'C', '1']]}
                    create_deck={'create_deck'}
                    isDragging={false}
                    draw_multiple={'draw_multiple'}
                    handId={'1'}
                    deck={[]}
                />
            </DragDropContext>
        )
        expect(getByAltText('5C')).toBeDefined()
        expect(getByAltText('5C').nodeName).toBe('IMG')
    })
    it('renders a card face down if the pile contains a deck', () => {
        const {container, getByAltText} = render (
            <DragDropContext onDragEnd={() => {}}>
                <GamePile
                    pileId={"pile1"}
                    numId={1}
                    roomId={1}
                    key={"pile1"}
                    pileCards={[['5', 'C', '1']]}
                    create_deck={'create_deck'}
                    isDragging={false}
                    draw_multiple={'draw_multiple'}
                    handId={'1'}
                    deck={["1"]}
                />
            </DragDropContext>
        )

        expect(getByAltText('BACK')).toBeDefined()
    })
    it('renders a only one card for a deck with many cards', () => {
        const {container, getAllByAltText} = render (
            <DragDropContext onDragEnd={() => {}}>
                <GamePile
                    pileId={"pile1"}
                    numId={1}
                    roomId={1}
                    key={"pile1"}
                    pileCards={[['5', 'C', '1'], ['6', 'S', '2'], ['Q', 'D', '3']]}
                    create_deck={'create_deck'}
                    isDragging={false}
                    draw_multiple={'draw_multiple'}
                    handId={'1'}
                    deck={["1"]}
                />
            </DragDropContext>
        )
        expect(getAllByAltText('BACK')).toBeDefined()
        expect(getAllByAltText('BACK').length).toBe(1)
    })
})