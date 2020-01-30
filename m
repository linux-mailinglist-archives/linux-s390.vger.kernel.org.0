Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77F0814D961
	for <lists+linux-s390@lfdr.de>; Thu, 30 Jan 2020 11:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgA3K5A (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 30 Jan 2020 05:57:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57736 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727027AbgA3K5A (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Jan 2020 05:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580381818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=v/c5WuRmJjSyh0i10nVFZoedypA1SrR8ZlJjz9/AM38=;
        b=e8DVuiMjg+tOYkahKK71Czjh8q05iL5SsfbwaqEd18o6if+qQqU5LYcxkEJbVPEm5l9hy0
        wwPcKuhXwRSfvi0g0aybfkAzb7yGGcbB1OM5ktI7rpwjdZ6bhZorC2ukMLcQ1DTWDDZbzd
        /8NSpw6/9e2F/DurRj0OieYPiASOYVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-7L0Ggzo6M2uGzhKIRccFVw-1; Thu, 30 Jan 2020 05:56:55 -0500
X-MC-Unique: 7L0Ggzo6M2uGzhKIRccFVw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0C0B10054E3;
        Thu, 30 Jan 2020 10:56:53 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-117.ams2.redhat.com [10.36.117.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9461E60BE0;
        Thu, 30 Jan 2020 10:56:49 +0000 (UTC)
Subject: Re: [PATCH/FIXUP FOR STABLE BEFORE THIS SERIES] KVM: s390: do not
 clobber user space fpc during guest reset
To:     Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        frankja@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, stable@kernel.org
References: <20200129200312.3200-2-frankja@linux.ibm.com>
 <1580374500-31247-1-git-send-email-borntraeger@de.ibm.com>
 <7b40856d-8153-ad3f-bea8-110fa6e1aea6@redhat.com>
 <20200130113941.78e4bf2e.cohuck@redhat.com>
From:   Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <336905ea-dc59-3118-9329-fc29c8386c52@redhat.com>
Date:   Thu, 30 Jan 2020 11:56:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200130113941.78e4bf2e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 30/01/2020 11.39, Cornelia Huck wrote:
> On Thu, 30 Jan 2020 10:49:35 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 30.01.20 09:55, Christian Borntraeger wrote:
>>> The initial CPU reset currently clobbers the userspace fpc. This was an
>>> oversight during a fixup for the lazy fpu reloading rework.  The reset
>>> calls are only done from userspace ioctls. No CPU context is loaded, so
>>> we can (and must) act directly on the sync regs, not on the thread
>>> context. Otherwise the fpu restore call will restore the zeroes fpc to
>>> userspace.
>>>
>>> Cc: stable@kernel.org
>>> Fixes: 9abc2a08a7d6 ("KVM: s390: fix memory overwrites when vx is disabled")
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>>  arch/s390/kvm/kvm-s390.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>> index c059b86..eb789cd 100644
>>> --- a/arch/s390/kvm/kvm-s390.c
>>> +++ b/arch/s390/kvm/kvm-s390.c
>>> @@ -2824,8 +2824,7 @@ static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
>>>  	vcpu->arch.sie_block->gcr[14] = CR14_UNUSED_32 |
>>>  					CR14_UNUSED_33 |
>>>  					CR14_EXTERNAL_DAMAGE_SUBMASK;
>>> -	/* make sure the new fpc will be lazily loaded */
>>> -	save_fpu_regs();
>>> +	vcpu->run->s.regs.fpc = 0;
>>>  	current->thread.fpu.fpc = 0;
>>>  	vcpu->arch.sie_block->gbea = 1;
>>>  	vcpu->arch.sie_block->pp = 0;
>>>   
>>
>> kvm_arch_vcpu_ioctl() does a vcpu_load(vcpu), followed by the call to
>> kvm_arch_vcpu_ioctl_initial_reset(), followed by a vcpu_put().
>>
>> What am I missing?
> 
> I have been staring at this patch for some time now, and I fear I'm
> missing something as well. Can we please get more explanation?

Could we please get a test for this issue in the kvm selftests, too?
I.e. host sets a value in its FPC, then calls the INITIAL_RESET ioctl
and then checks that the value in its FPC is still there?

 Thomas

