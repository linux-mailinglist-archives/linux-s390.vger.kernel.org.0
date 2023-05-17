Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38997062B3
	for <lists+linux-s390@lfdr.de>; Wed, 17 May 2023 10:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjEQIYj (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 17 May 2023 04:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjEQIY2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 17 May 2023 04:24:28 -0400
X-Greylist: delayed 595 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 May 2023 01:24:20 PDT
Received: from out-12.mta1.migadu.com (out-12.mta1.migadu.com [IPv6:2001:41d0:203:375::c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2EE3C06
        for <linux-s390@vger.kernel.org>; Wed, 17 May 2023 01:24:19 -0700 (PDT)
Message-ID: <b6b0a3ad-af30-371b-f46f-eb9524c7730d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684311261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U9RWU5du+4wKRasNfrMihyqwJ8yd3h31Dt6fxCtLe4M=;
        b=aONVDfrg2N47JooHBhu3b3TD379u6f0w2XnXCGXiwynXTmMketjjY2rMXNWuDhAEvxWHNl
        CSvB/sRqnlHQP0xaMja7zoaCmYyRuoBIeaLWRR38qqUywME8aq1vWc3e2DYzbpBOAO8auS
        x2S9kfE6GEm4CBo379HQmnj/J9q6LxY=
Date:   Wed, 17 May 2023 01:14:13 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 2/5] net/smc: allow smc to negotiate protocols
 on policies
Content-Language: en-US
To:     "D. Wythe" <alibuda@linux.alibaba.com>
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        bpf@vger.kernel.org, kgraul@linux.ibm.com, wenjia@linux.ibm.com,
        jaka@linux.ibm.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, pabeni@redhat.com, song@kernel.org,
        sdf@google.com, haoluo@google.com, yhs@fb.com, edumazet@google.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        guwen@linux.alibaba.com
References: <1683872684-64872-1-git-send-email-alibuda@linux.alibaba.com>
 <1683872684-64872-3-git-send-email-alibuda@linux.alibaba.com>
 <0e1656dc-b67c-ec65-83a4-6709fb186061@linux.dev>
 <beed306a-9f5a-c05b-6f0a-ee28e17f8100@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <beed306a-9f5a-c05b-6f0a-ee28e17f8100@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 5/17/23 12:08 AM, D. Wythe wrote:
> 
> 
> On 5/16/23 6:52 AM, Martin KaFai Lau wrote:
>> On 5/11/23 11:24 PM, D. Wythe wrote:
>>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>>
>>> As we all know, the SMC protocol is not suitable for all scenarios,
>>> especially for short-lived. However, for most applications, they cannot
>>> guarantee that there are no such scenarios at all. Therefore, apps
>>> may need some specific strategies to decide shall we need to use SMC
>>> or not.
>>>
>>> Just like the congestion control implementation in TCP, this patch
>>> provides a generic negotiator implementation. If necessary,
>>> we can provide different protocol negotiation strategies for
>>> apps based on this implementation.
>>>
>>> But most importantly, this patch provides the possibility of
>>> eBPF injection, allowing users to implement their own protocol
>>> negotiation policy in userspace.
>>>
>>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>>> ---
>>>   include/net/smc.h        |  32 +++++++++++
>>>   net/Makefile             |   1 +
>>>   net/smc/Kconfig          |  11 ++++
>>>   net/smc/af_smc.c         | 134 ++++++++++++++++++++++++++++++++++++++++++++++-
>>>   net/smc/smc_negotiator.c | 119 +++++++++++++++++++++++++++++++++++++++++
>>>   net/smc/smc_negotiator.h | 116 ++++++++++++++++++++++++++++++++++++++++
>>>   6 files changed, 412 insertions(+), 1 deletion(-)
>>>   create mode 100644 net/smc/smc_negotiator.c
>>>   create mode 100644 net/smc/smc_negotiator.h
>>>
>>> diff --git a/include/net/smc.h b/include/net/smc.h
>>> index 6d076f5..191061c 100644
>>> --- a/include/net/smc.h
>>> +++ b/include/net/smc.h
>>> @@ -296,6 +296,8 @@ struct smc_sock {                /* smc sock container */
>>>       atomic_t                queued_smc_hs;  /* queued smc handshakes */
>>>       struct inet_connection_sock_af_ops        af_ops;
>>>       const struct inet_connection_sock_af_ops    *ori_af_ops;
>>> +    /* protocol negotiator ops */
>>> +    const struct smc_sock_negotiator_ops *negotiator_ops;
>>>                           /* original af ops */
>>>       int            sockopt_defer_accept;
>>>                           /* sockopt TCP_DEFER_ACCEPT
>>> @@ -316,4 +318,34 @@ struct smc_sock {                /* smc sock container */
>>>                            */
>>>   };
>>>   +#ifdef CONFIG_SMC_BPF
>>> +/* BPF struct ops for smc protocol negotiator */
>>> +struct smc_sock_negotiator_ops {
>>> +
>>> +    struct list_head    list;
>>> +
>>> +    /* ops name */
>>> +    char        name[16];
>>> +    /* key for name */
>>> +    u32            key;
>>> +
>>> +    /* init with sk */
>>> +    void (*init)(struct sock *sk);
>>> +
>>> +    /* release with sk */
>>> +    void (*release)(struct sock *sk);
>>> +
>>> +    /* advice for negotiate */
>>> +    int (*negotiate)(struct sock *sk);
>>> +
>>> +    /* info gathering timing */
>>> +    void (*collect_info)(struct sock *sk, int timing);
>>> +
>>> +    /* module owner */
>>> +    struct module *owner;
>>> +};
>>> +#else
>>> +struct smc_sock_negotiator_ops {};
>>> +#endif
>>> +
>>>   #endif    /* _SMC_H */
>>> diff --git a/net/Makefile b/net/Makefile
>>> index 4c4dc53..222916a 100644
>>> --- a/net/Makefile
>>> +++ b/net/Makefile
>>> @@ -52,6 +52,7 @@ obj-$(CONFIG_TIPC)        += tipc/
>>>   obj-$(CONFIG_NETLABEL)        += netlabel/
>>>   obj-$(CONFIG_IUCV)        += iucv/
>>>   obj-$(CONFIG_SMC)        += smc/
>>> +obj-$(CONFIG_SMC_BPF)        += smc/smc_negotiator.o > 
>>> obj-$(CONFIG_RFKILL)        += rfkill/
>>>   obj-$(CONFIG_NET_9P)        += 9p/
>>>   obj-$(CONFIG_CAIF)        += caif/
>>> diff --git a/net/smc/Kconfig b/net/smc/Kconfig
>>> index 1ab3c5a..bdcc9f1 100644
>>> --- a/net/smc/Kconfig
>>> +++ b/net/smc/Kconfig
>>> @@ -19,3 +19,14 @@ config SMC_DIAG
>>>         smcss.
>>>           if unsure, say Y.
>>> +
>>> +config SMC_BPF
>>> +    bool "SMC: support eBPF" if SMC
>>
>>
>> so smc_negotiator will always be in the kernel image even af_smc is compiled 
>> as a module? If the SMC_BPF needs to support af_smc as a module, proper 
>> implementation needs to be added to bpf_struct_ops to support module first. It 
>> is work-in-progress.
>>
> 
> smc_negotiator will not no in the kernel image when af_smc is compiled as a module,
> it's requires config SMC_BPF also sets to be Y,  while it's default to be N. 
> That's is,
> even if af_smc is compiled as a module but with no SMC_BPF set, smc_negotiator
> doesn't exist anywhere.

CONFIG_SMC_BPF could be "y" while CONFIG_SMC is "m", no?

Anyway, there is a build error when CONFIG_SMC is "m" :(

> 
>>> +    depends on BPF_SYSCALL
>>> +    default n
>>> +    help
>>> +      Supports eBPF to allows user mode participation in SMC's protocol process
>>> +      via ebpf programs. Alternatively, obtain information about the SMC socks
>>> +      through the ebpf program.
>>> +
>>> +      If unsure, say N.
>>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>>> index 50c38b6..7406fd4 100644
>>> --- a/net/smc/af_smc.c
>>> +++ b/net/smc/af_smc.c
>>> @@ -52,6 +52,7 @@
>>>   #include "smc_close.h"
>>>   #include "smc_stats.h"
>>>   #include "smc_tracepoint.h"
>>> +#include "smc_negotiator.h"
>>>   #include "smc_sysctl.h"
>>>     static DEFINE_MUTEX(smc_server_lgr_pending);    /* serialize link group
>>> @@ -68,6 +69,119 @@
>>>   static void smc_tcp_listen_work(struct work_struct *);
>>>   static void smc_connect_work(struct work_struct *);
>>>   +#ifdef CONFIG_SMC_BPF
>>> +
>>> +/* Check if sock should use smc */
>>> +int smc_sock_should_select_smc(const struct smc_sock *smc)
>>> +{
>>> +    const struct smc_sock_negotiator_ops *ops;
>>> +    int ret;
>>> +
>>> +    rcu_read_lock();
>>> +    ops = READ_ONCE(smc->negotiator_ops);
>>> +
>>> +    /* No negotiator_ops supply or no negotiate func set,
>>> +     * always pass it.
>>> +     */
>>> +    if (!ops || !ops->negotiate) {
>>
>> A smc_sock_negotiator_ops without ->negotiate? Is it useful at all to allow 
>> the register in the first place?
>>
> 
> You are right, this can be avoid before registration. I'll fix it.
> 
>>> +        rcu_read_unlock();
>>> +        return SK_PASS;
>>> +    }
>>> +
>>> +    ret = ops->negotiate((struct sock *)&smc->sk);
>>> +    rcu_read_unlock();
>>> +    return ret;
>>> +}
>>> +
>>> +void smc_sock_perform_collecting_info(const struct smc_sock *smc, int timing)
>>> +{
>>> +    const struct smc_sock_negotiator_ops *ops;
>>> +
>>> +    rcu_read_lock();
>>> +    ops = READ_ONCE(smc->negotiator_ops);
>>> +
>>> +    if (!ops || !ops->collect_info) {
>>> +        rcu_read_unlock();
>>> +        return;
>>> +    }
>>> +
>>> +    ops->collect_info((struct sock *)&smc->sk, timing);
>>> +    rcu_read_unlock();
>>> +}
>>> +
>>> +int smc_sock_assign_negotiator_ops(struct smc_sock *smc, const char *name)
>>> +{
>>> +    struct smc_sock_negotiator_ops *ops;
>>> +    int ret = -EINVAL;
>>> +
>>> +    /* already set */
>>> +    if (READ_ONCE(smc->negotiator_ops))
>>> +        smc_sock_cleanup_negotiator_ops(smc, /* might be still referenced */ 
>>> false);
>>> +
>>> +    /* Just for clear negotiator_ops */
>>> +    if (!name || !strlen(name))
>>> +        return 0;
>>> +
>>> +    rcu_read_lock();
>>> +    ops = smc_negotiator_ops_get_by_name(name);
>>> +    if (likely(ops)) {
>>> +        if (unlikely(!bpf_try_module_get(ops, ops->owner))) {
>>> +            ret = -EACCES;
>>> +        } else {
>>> +            WRITE_ONCE(smc->negotiator_ops, ops);
>>> +            /* make sure ops can be seen */
>>> +            smp_wmb();
>>
>> This rcu_read_lock(), WRITE_ONCE, and smp_wmb() combo looks very suspicious. 
>> smc->negotiator_ops is protected by rcu (+refcnt) or lock_sock()?
>>
> 
> All access to ops is protected by RCU, and there are no lock_sock. WRITE_ONCE() 
> and smp_wmb() do
> not participate in any guarantee of the availability of ops,  The purpose to 
> using them is just wish the latest values
> can be read as soon as possible , In fact, even if old value is read, there will 
> be no problem in logic because all updates
> will do synchronize_rcu() and all access to ops is under in rcu_read_lock().

The explanation is not encouraging. No clear benefit while having this kind of 
complexity here. Switching tcp congestion ops also does not require this. Some 
of the new codes is in af_smc but bpf is the primary user. It is not something 
that I would like to maintain and then need to reason about this unusual pattern 
a year later. Beside, this negotiator_ops assignment must be done under a 
lock_sock(). The same probably is true for calling ops->negotiate() where the 
bpf prog may be looking at the sk and calling bpf_setsockopt.

> 
>> I am going to stop reviewing here.
>>
> 
> Hoping my explanation can answer your questions and still looking forward to
> your more feedback 😁.

Sorry, based on the review so far (there was some RFC before), it is not 
something that I want to continue to review and maintain a bpf hook for it. You 
have to solicit other known community members for review and sponsor this set 
from now on.
