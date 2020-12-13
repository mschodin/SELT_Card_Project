import * as React from "react";
import '@testing-library/jest-dom/extend-expect'
import { render, screen } from '@testing-library/react'
import RoomAppBar from "../../app/javascript/components/RoomAppBar";
import userEvent from '@testing-library/user-event'

describe('rendering the homepage application', ()=> {
    it("Should display the homepage header elements", () => {
        const test_greeting = "test greeting";
        const test_room_id = 1;
        const test_passcode = "abcd";

        render(<RoomAppBar greeting={test_greeting} room_passcode={test_passcode} room_id={test_room_id} />);

        expect(screen.getByText(test_greeting)).toBeInTheDocument();
        expect(screen.getByText("Room Code: "+test_passcode)).toBeInTheDocument();
    });

    it("Should display Leave/End Game buttons when clicked", ()=>{
        const test_greeting = "test greeting";
        const test_room_id = 1;
        const test_passcode = "abcd";

        render(<RoomAppBar greeting={test_greeting} room_passcode={test_passcode} room_id={test_room_id} />);

        userEvent.click(screen.getByLabelText('simple-menu'))
        expect(screen.getByText('Leave Game')).toBeInTheDocument()
        expect(screen.getByText('End Game')).toBeInTheDocument()
    })
});