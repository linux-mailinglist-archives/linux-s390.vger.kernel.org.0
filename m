Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AF4595606
	for <lists+linux-s390@lfdr.de>; Tue, 16 Aug 2022 11:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiHPJTu (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 16 Aug 2022 05:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiHPJTM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 16 Aug 2022 05:19:12 -0400
Received: from out199-2.us.a.mail.aliyun.com (out199-2.us.a.mail.aliyun.com [47.90.199.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E3F39B93;
        Tue, 16 Aug 2022 00:34:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VMP0xz3_1660635290;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0VMP0xz3_1660635290)
          by smtp.aliyun-inc.com;
          Tue, 16 Aug 2022 15:34:51 +0800
Date:   Tue, 16 Aug 2022 15:34:50 +0800
From:   Tony Lu <tonylu@linux.alibaba.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        zmlcc@linux.alibaba.com, hans@linux.alibaba.com,
        zhiyuan2048@linux.alibaba.com, herongguang@linux.alibaba.com
Subject: Re: [RFC net-next 1/1] net/smc: SMC for inter-VM communication
Message-ID: <YvtImtk0cqfhmZH+@TonyMac-Alibaba>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <20220720170048.20806-1-tonylu@linux.alibaba.com>
 <0ccf9cc6-4916-7815-9ce2-990dc7884849@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ccf9cc6-4916-7815-9ce2-990dc7884849@linux.ibm.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Aug 03, 2022 at 04:27:54PM -0400, Matthew Rosato wrote:
> On 7/20/22 1:00 PM, Tony Lu wrote:
> > Hi all,
> > 
> > # Background
> > 
> > We (Alibaba Cloud) have already used SMC in cloud environment to
> > transparently accelerate TCP applications with ERDMA [1]. Nowadays,
> > there is a common scenario that deploy containers (which runtime is
> > based on lightweight virtual machine) on ECS (Elastic Compute Service),
> > and the containers may want to be scheduled on the same host in order to
> > get higher performance of network, such as AI, big data or other
> > scenarios that are sensitive with bandwidth and latency. Currently, the
> > performance of inter-VM is poor and CPU resource is wasted (see
> > #Benchmark virtio). This scenario has been discussed many times, but a
> > solution for a common scenario for applications is missing [2] [3] [4].
> > 
> > # Design
> > 
> > In inter-VM scenario, we use ivshmem (Inter-VM shared memory device)
> > which is modeled by QEMU [5]. With it, multiple VMs can access one
> > shared memory. This shared memory device is statically created by host
> > and shared to desired guests. The device exposes as a PCI BAR, and can
> > interrupt its peers (ivshmem-doorbell).
> > 
> > In order to use ivshmem in SMC, we write a draft device driver as a
> > bridge between SMC and ivshmem PCI device. To make it easier, this
> > driver acts like a SMC-D device in order to fit in SMC without modifying
> > the code, which is named ivpci (see patch #1).
> > 
> >    ����������������������������������������������������������������������������������
> >    ��  ���������������������������������� ����������������������������������  ��
> >    ��  ��      VM1      �� ��      VM2      ��  ��
> >    ��  ���������������������������������� ����������������������������������  ��
> >    ��  ���� Application ���� ���� Application ����  ��
> >    ��  �������������������������������ȩ� �������������������������������ȩ�  ��
> >    ��  ����     SMC     ���� ����     SMC     ����  ��
> >    ��  �������������������������������ȩ� �������������������������������ȩ�  ��
> >    ��  ����    ivpci    ���� ����    ivpci    ����  ��
> >    ��  ���������������������������������� ����������������������������������  ��
> >    ��        x  *               x  *        ��
> >    ��        x  ****************x* *        ��
> >    ��        x  xxxxxxxxxxxxxxxxx* *        ��
> >    ��        x  x                * *        ��
> >    ��  ���������������������������������� ����������������������������������  ��
> >    ��  ��shared memories�� ��ivshmem-server ��  ��
> >    ��  ���������������������������������� ����������������������������������  ��
> >    ��                HOST A                 ��
> >    ����������������������������������������������������������������������������������
> >     *********** Control flow (interrupt)
> >     xxxxxxxxxxx Data flow (memory access)
> > 
> > Inside ivpci driver, it implements almost all the operations of SMC-D
> > device. It can be divided into two parts:
> > 
> > - control flow, most of it is same with SMC-D, use ivshmem trigger
> >    interruptions in ivpci and process CDC flow.
> > 
> > - data flow, the shared memory of each connection is one large region
> >    and divided into two part for local and remote RMB. Every writer
> >    syscall copies data to sndbuf and calls ISM's move_data() to move data
> >    to remote RMB in ivshmem and interrupt remote. And reader then
> >    receives interruption and check CDC message, consume data if cursor is
> >    updated.
> > 
> > # Benchmark
> > 
> > Current POC of ivpci is unstable and only works for single SMC
> > connection. Here is the brief data:
> > 
> > Items         Latency (pingpong)    Throughput (64KB)
> > TCP (virtio)   19.3 us                3794.185 MBps
> > TCP (SR-IOV)   13.2 us                3948.792 MBps
> > SMC (ivshmem)   6.3 us               11900.269 MBps
> > 
> > Test environments:
> > 
> > - CPU Intel Xeon Platinum 8 core, mem 32 GiB
> > - NIC Mellanox CX4 with 2 VFs in two different guests
> > - using virsh to setup virtio-net + vhost
> > - using sockperf and single connection
> > - SMC + ivshmem throughput uses one-copy (userspace -> kernel copy)
> >    with intrusive modification of SMC (see patch #1), latency (pingpong)
> >    use two-copy (user -> kernel and move_data() copy, patch version).
> > 
> > With the comparison, SMC with ivshmem gets 3-4x bandwidth and a half
> > latency.
> > 
> > TCP + virtio is the most usage solution for guest, it gains lower
> > performance. Moreover, it consumes extra thread with full CPU core
> > occupied in host to transfer data, wastes more CPU resource. If the host
> > is very busy, the performance will be worse.
> > 
> 
> Hi Tony,
> 
> Quite interesting!  FWIW for s390x we are also looking at passthrough of
> host ISM devices to enable SMC-D in QEMU guests:
> https://lore.kernel.org/kvm/20220606203325.110625-1-mjrosato@linux.ibm.com/
> https://lore.kernel.org/kvm/20220606203614.110928-1-mjrosato@linux.ibm.com/
> 
> But seems to me an 'emulated ISM' of sorts could still be interesting even
> on s390x e.g. for scenarios where host device passthrough is not
> possible/desired.
> 
> Out of curiosity I tried this ivpci module on s390x but the device won't
> probe -- This is possibly an issue with the s390x PCI emulation layer in
> QEMU, I'll have to look into that.
> 
> > # Discussion
> > 
> > This RFC and solution is still in early stage, so we want to come it up
> > as soon as possible and fully discuss with IBM and community. We have
> > some topics putting on the table:
> > 
> > 1. SMC officially supports this scenario.
> > 
> > SMC + ivshmem shows huge improvement when communicating inter VMs. SMC-D
> > and mocking ISM device might not be the official solution, maybe another
> > extension for SMC besides SMC-R and SMC-D. So we are wondering if SMC
> > would accept this idea to fix this scenario? Are there any other
> > possibilities?
> 
> I am curious about ivshmem and its current state though -- e.g. looking
> around I see mention of v2 which you also referenced but don't see any
> activity on it for a few years?  And as far as v1 ivshmem -- server "not for
> production use", etc.
> 
> Thanks,
> Matt
> 

Hi Matt,

Glad to hear that. And sorry for my late reply.

Current POC version of ivpci for 'emulated ISM' is unstable and buggy,
and depends on ivshmem [1] and a hypervisor process [2], maybe there are
some issues blocks that. Please point them out, and I will fix them.

The current state of ivshmem, yes, v1 is still unstable and v2 isn't
active for a long time. This patch uses ivshmem to act as backend of
emulated ISM device for prototype. And ivshmem doesn't suit for this
scenario as a product-level solution, such as interruption, shared
memory memory allocation and live migration etc.

So we are planning to come up with a new device and the corresponding
driver. We are trying to extend virtio for shared memory, so that it can
use shared memory in s390 or others scenarios. We are working on the
details and send out the proposal later. And what about your opinions?

[1] https://www.qemu.org/docs/master/system/devices/ivshmem.html
[2] https://github.com/qemu/qemu/tree/master/contrib/ivshmem-server

Cheers,
Tony Lu
