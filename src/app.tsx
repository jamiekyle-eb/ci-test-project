import React from "react"
import { render } from "react-dom"
import { Counter } from "./counter"

function App() {
	return <Counter />
}

render(<App />, document.getElementById("root"))
