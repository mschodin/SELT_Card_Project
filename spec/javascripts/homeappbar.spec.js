import * as React from "react";
import '@testing-library/jest-dom/extend-expect'
import { render, fireEvent, waitFor, screen } from '@testing-library/react'
import HomeAppBar from "../../app/javascript/components/HomeAppBar";

test("Check that the homepage headers are shown", ()=>{
    render(<HomeAppBar/>);
    expect(screen.getByText('Online Cards')).toBeInTheDocument();
});