let instance;
let inputAlloc;
let outputAlloc;

// When the input updates...
let input = () => {

  // Read input from textbox
  const input = document.getElementById('input').value;

  // Update buffer
  updateInputBuffer(input);
}

const importObject = {
  env: {
    onRendered(length) {
      // Create a buffer from the wasm buffer
      const view = new Uint8Array(instance.exports.memory.buffer, outputAlloc, length);

      // Decode buffer
      document.getElementById('app').innerHTML = new TextDecoder().decode(view);
    }
  }
};

(async() => {

  const obj = await WebAssembly.instantiateStreaming(fetch('./hello.wasm'), importObject);

  instance = obj.instance;

  // Create an input and output buffer memory allocation
  inputAlloc = instance.exports.alloc(1);
  outputAlloc = instance.exports.alloc(2);

  // Set the initial buffer
  updateInputBuffer("h Hello, Wasm!");
})();

const updateInputBuffer = (text: string) => {
  // Encode the text, add a null terminator
  const encodedText = new TextEncoder().encode(text + "\0");

  // Create and update view
  const view = new Uint8Array(instance.exports.memory.buffer, inputAlloc, 50);
  view.set(encodedText);

  // Call for render
  instance.exports.render();
};
