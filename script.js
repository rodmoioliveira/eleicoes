const {
  operators: { mergeMap, map, tap },
  fromEvent,
  of,
} = rxjs;

const data_candidate = [...document.querySelectorAll("[data-candidate]")];
const data_count = [...document.querySelectorAll("[data-count]")];
const data_votes = [...document.querySelectorAll("[data-votes]")];
const state = {
  data_candidate,
  data_count,
  data_votes,
  votes_candidates: Array(data_candidate.length).fill(0),
  votes_total: 0,
};

of(...state.data_candidate)
  .pipe(
    mergeMap((canditate) =>
      fromEvent(canditate, "click").pipe(
        map(() => canditate.getAttribute("data-candidate")),
        tap((i) => {
          state.votes_candidates[i] += 1;
          state.votes_total += 1;

          Array(1)
            .fill(0)
            .map(() => document.createElement("li"))
            .forEach((li) => {
              state.data_votes[i].appendChild(li);
            });
        }),
      ),
    ),
  )
  .subscribe(() => {
    state.data_count.forEach((c, i) => {
      c.textContent = state.votes_candidates[i];
    });
  });
