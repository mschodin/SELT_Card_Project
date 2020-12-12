import * as React from "react";
import {render} from "@testing-library/react";
import GameRoom from "../../app/javascript/components/GameRoom";

test('Check that GameTable exists', () => {
    const test_piles =  [[0,[["A", "S", 0],["A", "C", 1],["A", "H", 2]]],[ 1, [["A", "S", 0],["A", "C", 1],["A", "H", 2]]]]
    const test_hand =  [["A", "S", 0],["A", "C", 1],["A", "H", 2]]
    let test_players = {"test":0}
    const { getAllByRole, getByText, getByLabelText, getByTestId} = render(<GameRoom handId={0} playerHand={test_hand} piles={test_piles} players={test_players}/>);
    expect(getAllByRole('table').length).toBe(1)
    expect(getAllByRole('pile').length).toBe(test_piles.length)
});
