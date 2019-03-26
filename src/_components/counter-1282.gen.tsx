// Generated file, do not edit manually.
// CACHEBUSTER:A74A4FDB-D820-4D94-8D0E-C66A65495215
import React, { useState, useCallback } from "react"
import { css, cx } from "emotion"

export function Counter() {
	let [count, setCount] = useState(0)

	let increment = useCallback(() => setCount(count + 1), [count])
	let decrement = useCallback(() => setCount(count + 1), [count])
	let reset = useCallback(() => setCount(0), [])
	let update = useCallback(
		event => setCount(parseInt(event.currentTarget.value, 10)),
		[],
	)

	return (
		<div className={styles.counter}>
			<button className={styles.button} onClick={decrement}>
				{"-"}
			</button>
			<input
				type="number"
				className={styles.count}
				value={count}
				onChange={update}
			/>
			<button className={styles.button} onClick={increment}>
				{"+"}
			</button>
			<br />
			<button className={cx(styles.button, styles.reset)} onClick={reset}>
				{"Reset"}
			</button>
		</div>
	)
}

let styles = {
	counter: css`
		display: inline-block;
		margin: 1em;
		padding: 1em;
		background: #f3f3f3;
	`,
	button: css`
		border: none;
		font: inherit;
		padding: 0.5em 1em;
		background: dodgerblue;
		color: white;
		-webkit-font-smoothing: antialiased;
	`,
	count: css`
		display: inline-block;
		text-align: center;
		width: auto;
		font-size: 1.5em;
		line-height: 1;
		padding: 0 1em;
		margin: 0;
		background: transparent;
		border: none;
	`,

	reset: css`
		margin-top: 0.5em;
		width: 100%;
		background: gray;
	`,
}
