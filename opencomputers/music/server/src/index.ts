import express from "express";
import ffmpeg from "fluent-ffmpeg";
import fs from "fs";
import ytdl from "@distube/ytdl-core";

const app = express();
const port = 23457;

const getData = async (
  id: string,
  frequency: number = 32768
): Promise<Uint8Array> => {
  return new Promise(async (resolve, reject) => {
    const path = process.cwd().concat("/audio/");
    if (!fs.existsSync(path)) {
      fs.mkdirSync(path);
    }

    const file = path.concat(id, ".dfpwm");
    if (fs.existsSync(file)) {
      console.log("File already exists!");
      resolve(fs.readFileSync(file));
    }

    const stream = ytdl(`https://youtube.com/watch?v=${id}`, {
      quality: "highestaudio",
    });

    ffmpeg(stream)
      .audioCodec("dfpwm")
      .audioChannels(1)
      .audioFrequency(frequency)
      .save(file)
      .on("end", async () => {
        resolve(fs.readFileSync(file));
      })
      .on("error", (err) => {
        reject(err);
      });
  });
};

export function checkUrl(id: string) {
  return ytdl.validateID(id);
}
app.get("/get/:id?", async (req, res, next) => {
  const = videoId = req.params.id;
  if (!videoId) {
    res.sendStatus(400);
    next();
    return;
  } else if (checkUrl(videoId)) {
    let freq = parseInt(req.query?.freq + "");
    if (isNaN(freq)) {
      freq = 32768;
    }
    if (freq < 8000 || freq > 65536) {
      res.sendStatus(400);
      next();
      return;
    }
    console.log("Got request! ID: ", videoId);
    const data = await getData(videoId, freq);
    res.writeHead(200, { "Content-Type": "application/octet-stream" });
    res.end(data, "binary");
    console.log("Sent data for ID: ", videoId);
  } else {
    res.sendStatus(400);
  }
});

app.get("/", (_req, res) => {
  res.sendStatus(200);
});

app.listen(port, () => {
  console.log(`App listening on port ${port}`);
});
