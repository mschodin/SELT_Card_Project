import * as React from "react";
import '@testing-library/jest-dom/extend-expect'
import Home from "../../app/javascript/components/Home";
import { render, fireEvent, waitFor, screen } from '@testing-library/react'

describe(`showing user alert messages`, ()=> {

    it('Should display a FlashMessage', () => {
        const test_flash_message = "This is a test message";
        const {room_join_url, room_index_url} = "";
        const {getByText} = render(<Home room_join={room_join_url} room_create={room_index_url} flash_message={test_flash_message}/>);

        expect(screen.getByRole('alert')).toBeInTheDocument();
        expect(screen.getByRole('alert')).toHaveTextContent(test_flash_message);
    });

    it('Should not display a FlashMessage', () => {
        const test_flash_message = null;
        const {room_join_url, room_index_url} = "";
        const {getByText} = render(<Home room_join={room_join_url} room_create={room_index_url} flash_message={test_flash_message}/>);

        expect(screen.queryByRole('alert')).toBeNull()
    });
});