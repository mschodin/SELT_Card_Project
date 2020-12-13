import * as React from "react";
import '@testing-library/jest-dom/extend-expect'
import { render, screen } from '@testing-library/react'
import Home from "../../app/javascript/components/Home";

describe('Check that text displays when homepage is rendered', ()=>{
    it("Should display Create/Join Game text", ()=>{
        const test_flash_message = null;
        const {room_join_url, room_index_url} = "";
        render(<Home room_join={room_join_url} room_create={room_index_url} flash_message={test_flash_message}/>);
        expect(screen.getAllByText('Create Game').length).toBe(2);
        expect(screen.getAllByText('Join Game').length).toBe(2);
    })

    it("Should display the Create/Join Game submit buttons", ()=>{
        const test_flash_message = null;
        const {room_join_url, room_index_url} = "";
        render(<Home room_join={room_join_url} room_create={room_index_url} flash_message={test_flash_message}/>);
        expect(screen.getAllByLabelText('submit').length).toBe(2)
    })
})