Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E15DA14EE10
	for <lists+linux-s390@lfdr.de>; Fri, 31 Jan 2020 14:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgAaN7K (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 31 Jan 2020 08:59:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47483 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728500AbgAaN7J (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 31 Jan 2020 08:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580479148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hNUw6IPOMIG9KQCYecqbcrytZM2fmwuWhPjigAsREIk=;
        b=cTFdqIuCxDy6MEg0GmGsMYEEI6n49ZV2gcdmZ3cK0UI3kz9FdpvZYL756KeLXWRtyVletv
        k3CvXgGOALz9+mrXKouXZYaAV0RwIvU9UcBl+a6owVtJLjqz+KDzauTmHiM6GkLrdHzEdA
        8hnCQfcUzaP4hM/CngDE4OaCWtQpYGI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-zNi_IvQFPvuzU-1ZwLl10Q-1; Fri, 31 Jan 2020 08:59:07 -0500
X-MC-Unique: zNi_IvQFPvuzU-1ZwLl10Q-1
Received: by mail-wr1-f70.google.com with SMTP id s13so3372635wru.7
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 05:59:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hNUw6IPOMIG9KQCYecqbcrytZM2fmwuWhPjigAsREIk=;
        b=WweHkHOc0khJFNk/Qziin4uzVSUOASOHeUjIdK5Sd21ZEdTczl41bA5151zoD7F1iu
         SlIwcUEHvj8n4uQzYXRdrE1wbjcRVQIDWyFLhKlbKac7qz8HpoXy3zWYRIL/F4fW1dcv
         3gmuenPtpL0sbBK/vdiGcxLK5gKzofQSPsBUal6FciEimHbQeAe6tdJOTTDRPZgu/hiI
         C7gC68SusJ1bNQd9XQ7xeh309eBEbKgU3hGnr+hgg82WpHqgCbefQOk94iEQUdhrRYk1
         xgTQ0tdO4EahfKCXxqFf6b8V/UmFz/2smmDifcs7SZhg7pOHndCgAK8C7sAJMTitx0qB
         kypw==
X-Gm-Message-State: APjAAAUN3144jmOe59TbpXtggDFPPWPVnCE4VoGLtRVrsVqFN4GovJ8z
        0eCCM2WwzM0nhgCTN3ZrkqsChe68lWPZrzFGfcR6ucidU6QNq0krHT21oTD6tWzQwcFIUlShAio
        R1qjfOACJPzKVFqC7AZfqRw==
X-Received: by 2002:a5d:52c4:: with SMTP id r4mr12340679wrv.368.1580479145891;
        Fri, 31 Jan 2020 05:59:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqwq6gOWcudtpzerMxP8Ia/73h2By2Dmg/cNUGGxc6rZe83zEVp6sBSb5DIRUdVUqL6tDXWh3w==
X-Received: by 2002:a5d:52c4:: with SMTP id r4mr12340659wrv.368.1580479145631;
        Fri, 31 Jan 2020 05:59:05 -0800 (PST)
Received: from [192.168.43.81] (93-33-14-103.ip42.fastwebnet.it. [93.33.14.103])
        by smtp.gmail.com with ESMTPSA id b18sm12162460wru.50.2020.01.31.05.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 05:59:05 -0800 (PST)
Subject: Re: [PATCH v10 4/6] selftests: KVM: Add fpu and one reg set/get
 library functions
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
        linux-s390@vger.kernel.org
References: <20200131100205.74720-1-frankja@linux.ibm.com>
 <20200131100205.74720-5-frankja@linux.ibm.com>
 <6a990f23-832b-86f7-28bf-761e84fd33fb@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <75bddb63-fb5a-90b0-64bf-2de1d53f2b82@redhat.com>
Date:   Fri, 31 Jan 2020 14:59:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <6a990f23-832b-86f7-28bf-761e84fd33fb@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 31/01/20 12:43, Christian Borntraeger wrote:
> Paolo,
> 
> are you ok with me taking this patch for my s390 pull request to you?
> Ideally still for 5.6?

Yes to both questions, of course.

Paolo

> On 31.01.20 11:02, Janosch Frank wrote:
>> Add library access to more registers.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  .../testing/selftests/kvm/include/kvm_util.h  |  6 ++++
>>  tools/testing/selftests/kvm/lib/kvm_util.c    | 36 +++++++++++++++++++
>>  2 files changed, 42 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
>> index 29cccaf96baf..ae0d14c2540a 100644
>> --- a/tools/testing/selftests/kvm/include/kvm_util.h
>> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
>> @@ -125,6 +125,12 @@ void vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
>>  		    struct kvm_sregs *sregs);
>>  int _vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid,
>>  		    struct kvm_sregs *sregs);
>> +void vcpu_fpu_get(struct kvm_vm *vm, uint32_t vcpuid,
>> +		  struct kvm_fpu *fpu);
>> +void vcpu_fpu_set(struct kvm_vm *vm, uint32_t vcpuid,
>> +		  struct kvm_fpu *fpu);
>> +void vcpu_get_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg);
>> +void vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg);
>>  #ifdef __KVM_HAVE_VCPU_EVENTS
>>  void vcpu_events_get(struct kvm_vm *vm, uint32_t vcpuid,
>>  		     struct kvm_vcpu_events *events);
>> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
>> index 41cf45416060..a6dd0401eb50 100644
>> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
>> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
>> @@ -1373,6 +1373,42 @@ int _vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_sregs *sregs)
>>  	return ioctl(vcpu->fd, KVM_SET_SREGS, sregs);
>>  }
>>
>> +void vcpu_fpu_get(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_fpu *fpu)
>> +{
>> +	int ret;
>> +
>> +	ret = _vcpu_ioctl(vm, vcpuid, KVM_GET_FPU, fpu);
>> +	TEST_ASSERT(ret == 0, "KVM_GET_FPU failed, rc: %i errno: %i (%s)",
>> +		    ret, errno, strerror(errno));
>> +}
>> +
>> +void vcpu_fpu_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_fpu *fpu)
>> +{
>> +	int ret;
>> +
>> +	ret = _vcpu_ioctl(vm, vcpuid, KVM_SET_FPU, fpu);
>> +	TEST_ASSERT(ret == 0, "KVM_SET_FPU failed, rc: %i errno: %i (%s)",
>> +		    ret, errno, strerror(errno));
>> +}
>> +
>> +void vcpu_get_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg)
>> +{
>> +	int ret;
>> +
>> +	ret = _vcpu_ioctl(vm, vcpuid, KVM_GET_ONE_REG, reg);
>> +	TEST_ASSERT(ret == 0, "KVM_GET_ONE_REG failed, rc: %i errno: %i (%s)",
>> +		    ret, errno, strerror(errno));
>> +}
>> +
>> +void vcpu_set_reg(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_one_reg *reg)
>> +{
>> +	int ret;
>> +
>> +	ret = _vcpu_ioctl(vm, vcpuid, KVM_SET_ONE_REG, reg);
>> +	TEST_ASSERT(ret == 0, "KVM_SET_ONE_REG failed, rc: %i errno: %i (%s)",
>> +		    ret, errno, strerror(errno));
>> +}
>> +
>>  /*
>>   * VCPU Ioctl
>>   *
>>
> 

