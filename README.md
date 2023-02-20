# FCM Digital - Elixir Technical challenge

## Development

Fcm-Challenge is written in Elixir 1.14.3, over Erlang 25 running on top of [Docker compose](https://docs.docker.com/compose/) (it can be installed using `brew`).

```bash
git clone https://github.com/jgtomas/fcm.git
cd fcm

# build
docker compose build

# Run the console container
docker compose exec fcm_challenge sh

```

And you're ready to test it! 🚀

```bash
# Inside beam container
mix test
# or one command
docker compose exec fcm_challenge mix test
```

Oh! Wait! One last thing 👀
If you want to execute the exercise, you just have to:
```bash
docker compose exec fcm_challenge mix run -e "Fcm.start('test/fixtures/file_1.txt')"
```

## Notes

We have chosen for a solution which consists of transforming the unstructured data (text file) into a structured format (fcm/struts/traveler.ex)
, this helps us to filter/group/order more easily.

- We always expect a plain text file (no pdf, docx..)
- We always expect the header of the file to be the `BASED:`
- We always expect a single `BASED:` (no multiples based in file)
- If the label is different from `hotel,flight or train` we show a custom message in the console output but without throwing an exception (we have another alternative, which would be to discard the segment)