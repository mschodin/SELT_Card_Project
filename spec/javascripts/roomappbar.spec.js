import * as React from "react";
import { render, fireEvent, waitFor, screen } from '@testing-library/react'
import RoomAppBar from "../../app/javascript/components/RoomAppBar";
import Home from "../../app/javascript/components/Home";
import { shallow, mount } from 'enzyme';

describe('rendering the homepage application', ()=> {
    it("Should display the homepage header elements", () => {
        const test_greeting = "test greeting";
        const test_room_id = 1;
        const test_passcode = "abcd";

        render(<RoomAppBar greeting={test_greeting} room_passcode={test_passcode} room_id={test_room_id} />);
        expect(screen.getByText(test_greeting)).toBeInTheDocument();
        expect(screen.getByText(test_passcode)).toBeInTheDocument();
    });
});