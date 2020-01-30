Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5168114D95D
	for <lists+linux-s390@lfdr.de>; Thu, 30 Jan 2020 11:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgA3Kz4 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 30 Jan 2020 05:55:56 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28878 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726949AbgA3Kzy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jan 2020 05:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580381753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RNdpTv8/BrLSjoqi3GGq0WCugv3jgZPx4+KYMC12UK0=;
        b=Ayo6qs3HcfF0M3I7PpauwHGhHqK6idWVfeRn0jcGpl5WGZa4axG6NX9Ze6TZy43OXAUwVR
        3+Jer6fKoKD6JLvSkm2ZFi4zfC0Hs3xIq1BhbnOIi6aZH0KLc3LWQhzNZhaqxVcX9CTuoh
        n6qa9u0M4pb73lw3lntog0YcAqeL1wU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-iIaEKTyQPmit5T1r_O0qrA-1; Thu, 30 Jan 2020 05:55:51 -0500
X-MC-Unique: iIaEKTyQPmit5T1r_O0qrA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B34E68017CC;
        Thu, 30 Jan 2020 10:55:50 +0000 (UTC)
Received: from gondolin (ovpn-117-199.ams2.redhat.com [10.36.117.199])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B428D1001925;
        Thu, 30 Jan 2020 10:55:46 +0000 (UTC)
Date:   Thu, 30 Jan 2020 11:55:43 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com,
        david@redhat.com, linux-s390@vger.kernel.org
Subject: Re: [PATCH v8 4/4] selftests: KVM: testing the local IRQs resets
Message-ID: <20200130115543.1f06a840.cohuck@redhat.com>
In-Reply-To: <20200129200312.3200-5-frankja@linux.ibm.com>
References: <20200129200312.3200-1-frankja@linux.ibm.com>
        <20200129200312.3200-5-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 29 Jan 2020 15:03:12 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> From: Pierre Morel <pmorel@linux.ibm.com>
> 
> Local IRQs are reset by a normal cpu reset.  The initial cpu reset and
> the clear cpu reset, as superset of the normal reset, both clear the
> IRQs too.
> 
> Let's inject an interrupt to a vCPU before calling a reset and see if
> it is gone after the reset.
> 
> We choose to inject only an emergency interrupt at this point and can
> extend the test to other types of IRQs later.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>

You probably should add your s-o-b here as well.

> ---
>  tools/testing/selftests/kvm/s390x/resets.c | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/resets.c b/tools/testing/selftests/kvm/s390x/resets.c
> index 2b2378cc9e80..299c1686f98c 100644
> --- a/tools/testing/selftests/kvm/s390x/resets.c
> +++ b/tools/testing/selftests/kvm/s390x/resets.c
> @@ -14,6 +14,9 @@
>  #include "kvm_util.h"
>  
>  #define VCPU_ID 3
> +#define LOCAL_IRQS 32

Why 32?

> +
> +struct kvm_s390_irq buf[VCPU_ID + LOCAL_IRQS];
>  
>  struct kvm_vm *vm;
>  struct kvm_run *run;
> @@ -52,6 +55,29 @@ static void test_one_reg(uint64_t id, uint64_t value)
>  	TEST_ASSERT(eval_reg == value, "value == %s", value);
>  }
>  
> +static void assert_noirq(void)
> +{
> +	struct kvm_s390_irq_state irq_state;
> +	int irqs;
> +
> +	if (!(kvm_check_cap(KVM_CAP_S390_INJECT_IRQ) &&
> +	    kvm_check_cap(KVM_CAP_S390_IRQ_STATE)))
> +		return;

Might want to do a

irq_introspection_supported = (check stuff);

once for this test? Works fine as is, of course.

> +
> +	irq_state.len = sizeof(buf);
> +	irq_state.buf = (unsigned long)buf;
> +	irqs = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_GET_IRQ_STATE, &irq_state);
> +	/*
> +	 * irqs contains the number of retrieved interrupts, apart from the
> +	 * emergency call that should be cleared by the resets, there should be
> +	 * none.

Even if there were any, they should have been cleared by the reset,
right?

> +	 */
> +	if (irqs < 0)
> +		printf("Error by getting IRQ: errno %d\n", errno);

"Error getting pending IRQs" ?

> +
> +	TEST_ASSERT(!irqs, "IRQ pending");
> +}
> +
>  static void assert_clear(void)
>  {
>  	struct kvm_sregs sregs;
> @@ -93,6 +119,31 @@ static void assert_initial(void)
>  static void assert_normal(void)
>  {
>  	test_one_reg(KVM_REG_S390_PFTOKEN, KVM_S390_PFAULT_TOKEN_INVALID);
> +	assert_noirq();
> +}
> +
> +static int inject_irq(int cpu_id)

You never seem to check the return code.

> +{
> +	struct kvm_s390_irq_state irq_state;
> +	struct kvm_s390_irq *irq = &buf[0];
> +	int irqs;
> +
> +	if (!(kvm_check_cap(KVM_CAP_S390_INJECT_IRQ) &&
> +	    kvm_check_cap(KVM_CAP_S390_IRQ_STATE)))
> +		return 0;
> +
> +	/* Inject IRQ */
> +	irq_state.len = sizeof(struct kvm_s390_irq);
> +	irq_state.buf = (unsigned long)buf;
> +	irq->type = KVM_S390_INT_EMERGENCY;
> +	irq->u.emerg.code = cpu_id;
> +	irqs = _vcpu_ioctl(vm, cpu_id, KVM_S390_SET_IRQ_STATE, &irq_state);
> +	if (irqs < 0) {
> +		printf("Error by injecting INT_EMERGENCY: errno %d\n", errno);

"Error injecting EMERGENCY IRQ" ?

> +		return errno;
> +	}
> +
> +	return 0;
>  }
>  
>  static void test_normal(void)
> @@ -105,6 +156,8 @@ static void test_normal(void)
>  
>  	_vcpu_run(vm, VCPU_ID);
>  
> +	inject_irq(VCPU_ID);
> +
>  	vcpu_ioctl(vm, VCPU_ID, KVM_S390_NORMAL_RESET, 0);
>  	assert_normal();
>  	kvm_vm_free(vm);
> @@ -122,6 +175,8 @@ static int test_initial(void)
>  
>  	rv = _vcpu_run(vm, VCPU_ID);
>  
> +	inject_irq(VCPU_ID);
> +
>  	vcpu_ioctl(vm, VCPU_ID, KVM_S390_INITIAL_RESET, 0);
>  	assert_normal();
>  	assert_initial();
> @@ -141,6 +196,8 @@ static int test_clear(void)
>  
>  	rv = _vcpu_run(vm, VCPU_ID);
>  
> +	inject_irq(VCPU_ID);
> +
>  	vcpu_ioctl(vm, VCPU_ID, KVM_S390_CLEAR_RESET, 0);
>  	assert_normal();
>  	assert_initial();

On the whole, looks good to me.

