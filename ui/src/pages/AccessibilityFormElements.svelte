<script lang="ts">
  import MainPageLayout from 'src/layout/MainPageLayout.svelte'
  import Badge from 'src/components/Badge.svelte'
  import Button from 'src/components/Button.svelte'
  import FormField from 'src/forms/FormField.svelte'
  import CheckboxField from 'src/forms/CheckboxField.svelte'
  import SelectField from 'src/forms/SelectField.svelte'
  import TextAreaField from 'src/forms/TextAreaField.svelte'
  import RangeSlider from 'src/forms/RangeSlider.svelte'
  import RadioButton from 'src/forms/RadioButton.svelte'

  // Form data type
  type FormDataType = {
    name: string;
    email: string;
    password: string;
    bio: string;
    rank: string;
    agree: boolean;
    gender: string;
    file: File | null;
    dob: string;
    age: number | '';
    skill: number;
    onDuty: boolean;
  };

  let formData: FormDataType = {
    name: '',
    email: '',
    password: '',
    bio: '',
    rank: '',
    agree: false,
    gender: '',
    file: null,
    dob: '',
    age: '',
    skill: 50,
    onDuty: false
  }
  const Genders = {
    male: 'Male',
    female: 'Female',
    helicopter: 'Attack helicopter'
  }
  let Gender: keyof typeof Genders

  function handleSubmit() {
    // You can handle form submission here
    alert('Form submitted!')
  }
</script>

<MainPageLayout>
  <main id="main" tabindex="-1" aria-label="Army Enlistment Form">
    <div class="flex justify-center items-center">
      <div class="flex justify-center min-w-[440px] px-6 py-4 rounded-2xl bg-white shadow">
        <form class="flex w-full flex-col gap-4" on:submit|preventDefault={handleSubmit}>
          <div class="flex gap-2 items-center">
            <h2 aria-hidden="true">Army Enlistment Form </h2>
            <div>
              <Badge size="sm" color="success">Personal invite</Badge>
            </div>
          </div>
          <FormField label="Full Name" id="name" bind:value={formData.name} required/>
          <FormField label="Email" id="email" type="email" bind:value={formData.email} required/>
          <FormField label="Password" id="password" type="password" bind:value={formData.password} required/>
          <TextAreaField label="Bio" id="bio" bind:value={formData.bio} rows={3}/>
          <SelectField label="Rank" id="rank" bind:value={formData.rank} options={["Select rank", "Private", "Sergeant", "Captain"]}/>
          <CheckboxField label="I agree to the army code of conduct" bind:checked={formData.agree}/>
          <RadioButton label="Gender"
                       options={Genders}
                       bind:value={formData.gender}
                       class="classic flex-col gap-1"
          />

          <FormField label="Upload ID" id="file" type="file" on:change={e => formData.file = (e.target instanceof HTMLInputElement && e.target.files ? e.target.files[0] : null)}/>
          <FormField label="Date of Birth" id="dob" type="date" bind:value={formData.dob}/>
          <FormField label="Age" id="age" type="number" min="18" max="60" bind:value={formData.age}/>
          <RangeSlider label="Skill Level" id="skill" min={0} max={100} bind:value={formData.skill}/>
          <CheckboxField label="On Duty" bind:checked={formData.onDuty}/>
          <Button type="submit">Enlist</Button>
        </form>
      </div>
    </div>
  </main>
</MainPageLayout>
