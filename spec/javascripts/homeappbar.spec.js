import * as React from "react";
import '@testing-library/jest-dom/extend-expect'
import { render, fireEvent, waitFor, screen } from '@testing-library/react'
import HomeAppBar from "../../app/javascript/components/HomeAppBar";
import Home from "../../app/javascript/components/Home";
import { shallow, mount } from 'enzyme';

describe('rendering the homepage application', ()=> {
    it("Should display the homepage header elements", () => {
        render(<HomeAppBar/>);
        expect(screen.getByText('Online Cards')).toBeInTheDocument();
        expect(screen.getByRole('button')).toBeTruthy()
    });
});