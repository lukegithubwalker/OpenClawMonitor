window.ThreeBridge = (function () {
  let scene, camera, renderer, cube;

  function init() {
    const container = document.getElementById("three-container");
    scene = new THREE.Scene();
    camera = new THREE.PerspectiveCamera(60, container.clientWidth / container.clientHeight, 0.1, 1000);
    renderer = new THREE.WebGLRenderer({ antialias: true });
    renderer.setSize(container.clientWidth, container.clientHeight);
    container.appendChild(renderer.domElement);

    const geometry = new THREE.BoxGeometry();
    const material = new THREE.MeshStandardMaterial({ color: 0x00ffcc });
    cube = new THREE.Mesh(geometry, material);
    scene.add(cube);

    const light = new THREE.PointLight(0xffffff, 1);
    light.position.set(5, 5, 5);
    scene.add(light);

    camera.position.z = 3;
    animate();
  }

  function animate() {
    requestAnimationFrame(animate);
    renderer.render(scene, camera);
  }

  function updateMetrics(cpu, mem) {
    cube.rotation.x += cpu / 100;
    cube.rotation.y += mem / 100;
  }

  return { init, updateMetrics };
})();