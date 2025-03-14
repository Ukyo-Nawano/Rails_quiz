document.addEventListener("DOMContentLoaded", function () {
    
    let questionIndex = document.querySelectorAll(".question-fields").length;

    // 質問を追加
    document.getElementById("add-question").addEventListener("click", function () {
        const container = document.getElementById("questions-fields");
        const newField = document.createElement("div");
        newField.classList.add("question-fields", "mb-4");

        newField.innerHTML = `
        <div class="mb-4">
            <input type="hidden" name="quiz[questions_attributes][${questionIndex}][id]" value="">
            <input type="text" name="quiz[questions_attributes][${questionIndex}][content]" placeholder="質問内容" class="w-full p-3 border rounded-lg mt-4">
            <div class="choices-fields">
                <div class="choice-fields mb-2">
                <input type="text" name="quiz[questions_attributes][${questionIndex}][choices_attributes][0][name]" placeholder="選択肢1" class="w-full p-3 border rounded-lg mt-4">
                <input type="hidden" name="quiz[questions_attributes][${questionIndex}][choices_attributes][0][is_valid]" value="false">
                <input type="radio" name="quiz[questions_attributes][${questionIndex}][correct_choice]" value="0" class="ml-2"> 正解
                </div>
                <div class="choice-fields mb-2">
                <input type="text" name="quiz[questions_attributes][${questionIndex}][choices_attributes][1][name]" placeholder="選択肢2" class="w-full p-3 border rounded-lg mt-4">
                <input type="hidden" name="quiz[questions_attributes][${questionIndex}][choices_attributes][1][is_valid]" value="false">
                <input type="radio" name="quiz[questions_attributes][${questionIndex}][correct_choice]" value="1" class="ml-2"> 正解
                </div>
                <div class="choice-fields mb-2">
                <input type="text" name="quiz[questions_attributes][${questionIndex}][choices_attributes][2][name]" placeholder="選択肢3" class="w-full p-3 border rounded-lg mt-4">
                <input type="hidden" name="quiz[questions_attributes][${questionIndex}][choices_attributes][2][is_valid]" value="false">
                <input type="radio" name="quiz[questions_attributes][${questionIndex}][correct_choice]" value="2" class="ml-2"> 正解
                </div>
            </div>
            <textarea name="quiz[questions_attributes][${questionIndex}][supplement]" placeholder="解説・参考" class="w-full p-3 border rounded-lg mt-4" rows="3"></textarea>
            <input type="hidden" name="quiz[questions_attributes][${questionIndex}][_destroy]" value="false">
            <div class="mb-4">
                <label for="quiz[questions_attributes][${questionIndex}][point_id]" class="block text-lg font-semibold">ポイント</label>
                <select name="quiz[questions_attributes][${questionIndex}][point_id]" class="w-full p-3 border rounded-lg">
                    <option value="">ポイントを選択してください</option>
                    ${window.availablePoints.map(point =>
                        `<option value="${point.id}">${point.point}ポイント</option>`
                    ).join('')}
                </select>
            </div>
            <button type="button" class="remove-question text-[#3DB8A4] hover:underline bg-red-500 text-white py-2 px-6 rounded-lg shadow-md text-center block mt-6 mx-auto max-w-md">削除</button>
        </div>
    `;

        container.appendChild(newField);
        questionIndex++;

        // 削除ボタンのイベントリスナーを新たに追加
        newField.querySelector(".remove-question").addEventListener("click", function () {
            newField.remove();
        });
    });

    // 正解のラジオボタンが選択されたとき、選択肢のis_validをtrueに設定
    document.getElementById("questions-fields").addEventListener("change", function (event) {
        if (event.target.type === "radio" && event.target.name.includes("correct_choice")) {
            const questionField = event.target.closest(".question-fields");
            const allChoiceRadios = questionField.querySelectorAll("input[type='radio']");
            
            // すべての選択肢の is_valid を false にする
            allChoiceRadios.forEach(radio => {
                const hiddenInput = radio.closest('.choice-fields').querySelector('input[type="hidden"]');
                if (hiddenInput) {
                    hiddenInput.value = "false";
                }
            });
            
            // 選択された選択肢の is_valid を true にする
            const selectedChoiceField = event.target.closest('.choice-fields');
            const hiddenInput = selectedChoiceField.querySelector('input[type="hidden"]');
            if (hiddenInput) {
                hiddenInput.value = "true";
            }
        }
    });

    const addQuestionButton = document.getElementById("add-question");
    if (addQuestionButton) {
        addQuestionButton.addEventListener("click", function () {
        });
    }

    // 正解のラジオボタンのイベントリスナー
    const questionsFields = document.getElementById("questions-fields");
    if (questionsFields) {
        questionsFields.addEventListener("change", function (event) {
        });
    }

    document.querySelector("form").addEventListener("submit", function (event) {
        let errors = [];
        const title = document.querySelector("input[name='quiz[title]']").value.trim();
        const tags = document.querySelectorAll("input[name='quiz[tag_ids][]']:checked");
        const questions = document.querySelectorAll(".question-fields");

        if (tags.length === 0) {
            errors.push("タグを1つ以上選択してください。");
        }
        if (title.length < 1 || title.length > 50) {
            errors.push("クイズタイトルは1文字以上50文字以内で入力してください。");
        }
        if (questions.length < 1) {
            errors.push("設問を1問以上追加してください。");
        }

        questions.forEach((question, index) => {
            const content = question.querySelector(`input[name^='quiz[questions_attributes][${index}][content]']`).value.trim();
            const supplement = question.querySelector(`textarea[name^='quiz[questions_attributes][${index}][supplement]']`).value.trim();
            const choices = question.querySelectorAll(`input[name^='quiz[questions_attributes][${index}][choices_attributes]'][type="text"]`);
            const point = question.querySelector(`select[name^='quiz[questions_attributes][${index}][point_id]']`).value;
            const correctChoice = question.querySelectorAll(`input[name^='quiz[questions_attributes][${index}][correct_choice]']:checked`);

            if (content.length < 1 || content.length > 50) {
                errors.push(`設問${index + 1}の内容は1文字以上50文字以内で入力してください。`);
            }
            if (supplement.length > 0 && supplement.length > 50) {
                errors.push(`設問${index + 1}の解説は1文字以上50文字以内で入力してください。`);
            }
            if (!point) {
                errors.push(`設問${index + 1}のポイントを選択してください。`);
            }
            if (choices.length < 2) {
                errors.push(`設問${index + 1}には2つ以上の選択肢が必要です。`);
            }
            choices.forEach((choice, choiceIndex) => {
                if (choice.value.trim().length < 1 || choice.value.trim().length > 50) {
                    errors.push(`設問${index + 1}の選択肢${choiceIndex + 1}の内容は1文字以上50文字以内で入力してください。`);
                }
            });
            if (correctChoice.length === 0) {
                errors.push(`設問${index + 1}の正解を1つ選択してください。`);
            }
        });

        if (errors.length > 0) {
            event.preventDefault();
            alert(errors.join("\n"));
        }
    });
});
