import React from "react"
import { render } from "react-dom"
import { COMPONENTS } from "./_components.gen"

function App() {
	return (
		<>
			{COMPONENTS.map((Component, index) => (
				<Component key={index} />
			))}
		</>
	)
}

render(<App />, document.getElementById("root"))
