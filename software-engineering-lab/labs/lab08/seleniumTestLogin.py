import pytest
import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException

# Fixture to set up and tear down WebDriver
@pytest.fixture
def driver():
    driver = webdriver.Chrome()  # Ensure chromedriver is in PATH
    driver.get("http://127.0.0.1:5500/index1.html")  # Adjust URL as needed
    yield driver
    time.sleep(2)  # Pause 2 seconds before closing browser for observation
    driver.quit()

# Helper function for slow typing
def slow_type(element, text, delay=0.2):
    for char in text:
        element.send_keys(char)
        time.sleep(delay)  # Pause 0.2 seconds per character

# Test case 1: Successful login
def test_successful_login(driver):
    # Locate form elements
    username_input = driver.find_element(By.ID, "username")
    password_input = driver.find_element(By.ID, "password")
    login_button = driver.find_element(By.ID, "loginBtn")
    
    # Enter valid credentials with slow typing
    slow_type(username_input, "admin")  # Slowly type 'admin'
    time.sleep(2)  # Pause 2 seconds after username
    slow_type(password_input, "admin123")  # Slowly type 'admin123'
    time.sleep(2)  # Pause 2 seconds after password
    login_button.click()
    time.sleep(2)  # Pause 2 seconds after clicking
    
    # Wait for success message (10 seconds, increase to 15 if needed)
    try:
        success_message = WebDriverWait(driver, 10).until(
            EC.visibility_of_element_located((By.ID, "successMessage"))
        )
        assert success_message.text == "Đăng nhập thành công! Đang chuyển hướng..."
        assert success_message.is_displayed()
    except TimeoutException:
        assert False, "Success message did not appear within 10 seconds"

# Test case 2: Failed login
def test_failed_login(driver):
    # Locate form elements
    username_input = driver.find_element(By.ID, "username")
    password_input = driver.find_element(By.ID, "password")
    login_button = driver.find_element(By.ID, "loginBtn")
    
    # Enter invalid credentials with slow typing
    slow_type(username_input, "wronguser")
    time.sleep(2)  # Pause 2 seconds after username
    slow_type(password_input, "wrongpass")
    time.sleep(2)  # Pause 2 seconds after password
    login_button.click()
    time.sleep(2)  # Pause 2 seconds after clicking
    
    # Wait for error message (10 seconds, increase to 15 if needed)
    try:
        password_error = WebDriverWait(driver, 10).until(
            EC.visibility_of_element_located((By.ID, "passwordError"))
        )
        assert password_error.text == "Tên đăng nhập hoặc mật khẩu không đúng"
        assert password_error.is_displayed()
    except TimeoutException:
        assert False, "Error message for failed login did not appear within 10 seconds"

# Test case 3: Empty input
def test_empty_input(driver):
    # Locate form elements
    username_input = driver.find_element(By.ID, "username")
    password_input = driver.find_element(By.ID, "password")
    login_button = driver.find_element(By.ID, "loginBtn")
    
    # Submit form without entering credentials
    username_input.send_keys("")  # Ensure fields are empty
    password_input.send_keys("")
    time.sleep(2)  # Pause 2 seconds before clicking
    login_button.click()
    time.sleep(2)  # Pause 2 seconds after clicking
    
    # Wait for both error messages (10 seconds, increase to 15 if needed)
    try:
        username_error = WebDriverWait(driver, 10).until(
            EC.visibility_of_element_located((By.ID, "usernameError"))
        )
        password_error = WebDriverWait(driver, 10).until(
            EC.visibility_of_element_located((By.ID, "passwordError"))
        )
        assert username_error.text == "Vui lòng nhập tên đăng nhập"
        assert username_error.is_displayed()
        assert password_error.text == "Vui lòng nhập mật khẩu"
        assert password_error.is_displayed()
    except TimeoutException:
        assert False, "Error messages for empty input did not appear within 10 seconds"