import * as React from "react";
import '@testing-library/jest-dom/extend-expect'
import { render, fireEvent, waitFor, screen } from '@testing-library/react'
import HomeAppBar from "../../app/javascript/components/HomeAppBar";
import { shallow, mount } from 'enzyme';
import Home from "../../app/javascript/components/Home";
import {TextField} from "@material-ui/core";

describe('Check that text displays when homepage is rendered', ()=>{
    it("Should display Create/Join Game text", ()=>{
        const test_flash_message = null;
        const {room_join_url, room_index_url} = "";
        render(<Home room_join={room_join_url} room_create={room_index_url} flash_message={test_flash_message}/>);
        expect(screen.getAllByText('Create Game').length).toBe(2);
        expect(screen.getAllByText('Join Game').length).toBe(2);
    })
})


test("Check that onChange updates text field", ()=>{
    // const test_flash_message = null;
    // const {room_join_url, room_index_url} = "";
    // render(<Home room_join={room_join_url} room_create={room_index_url} flash_message={test_flash_message}/>);
    //
    // const onChangeMock = jest.fn();
    // const event = {
    //     target: { value: 'test' }
    // }
    // const component = mount<TextField>(<TextField onChange={onChangeMock} />);
    // const instance = component.instance();
    // instance.onChange(event);
    // expect(onChangeMock).toBeCalledWith('test');
});

test('calls onSubmit prop function when form is submitted', () => {
    // const onSubmitFn = jest.fn();
    // const wrapper = mount(<form onSubmit={onSubmitFn}/>);
    // const form = wrapper.find('form');
    // form.simulate('submit');
    // expect(onSubmitFn).toHaveBeenCalledTimes(1);
});