Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235B0617EDE
	for <lists+linux-s390@lfdr.de>; Thu,  3 Nov 2022 15:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiKCOFe (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 3 Nov 2022 10:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiKCOFc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Nov 2022 10:05:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820B7E02F
        for <linux-s390@vger.kernel.org>; Thu,  3 Nov 2022 07:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667484272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2ld7KbWWPpVg/DGXuI3WKVRs5TJPSNq4PfcjQdMphjo=;
        b=TIg+51sv9tDEUSq6IOaVuwny39JovqWxdcTcunN2U06XhDs27otMQcwAlIhhoIiThO5krW
        Mi9JKJ1W9P9bj2J6B5WpMZKkmnp/f9zAS9JmL8c9mFISt6pN0lzlgh1A6iUiF98SU8OAYa
        wCloePE90BqllGa9+kbCjCASd1bx72c=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-639-qQtqGie5PX2W7WS0_dazvQ-1; Thu, 03 Nov 2022 10:04:30 -0400
X-MC-Unique: qQtqGie5PX2W7WS0_dazvQ-1
Received: by mail-vs1-f72.google.com with SMTP id a6-20020a671a06000000b003986a4e277dso1064872vsa.12
        for <linux-s390@vger.kernel.org>; Thu, 03 Nov 2022 07:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ld7KbWWPpVg/DGXuI3WKVRs5TJPSNq4PfcjQdMphjo=;
        b=jjMmxxinqkEE/d9+LG0TDoMeaoXOc1W6CyLahXzWl/CIuDD4r+LqsEZQqgnYrrZOgY
         scZMlZbfkaQ+rBmgIUWoZM2POS5s2SFjVcEuMB+fp9kqtJ8roC3d5owXCf9+kqrZOgo2
         EUH2LJXu+/s8hRweL2nqhTjzykiA8ew/wfLViL2dq51BrUz0P1mkYudta6yY2U4d7dsu
         p6F01n7CvmePJI7UctRPLGwP03nO8Ud9FMN3ZFnX9eO4NJkD3ma20VauiqlGg9NMlp7C
         Fn8h5B28XogG7YnNJOHxCJi7bZLHr1Nm2MIAnx9F+FavbWPiykYnHAYPpmFrqstPxCNY
         e5mA==
X-Gm-Message-State: ACrzQf3ibK9Zi0Mos8XwE2GtoOdRDb6n+cmPSGBmwWZImXgJKNTNpewE
        A5qpHJN+Z7b1e7nw8heE+9ltqOczq0OxmTF1/G0tGp3+038lZpoCSgFo7Qcj0Ti5YuRr7mS8SJb
        Txv1QK4/M/zbQ6vCR59Sfg264iJTePKj9RSB7PQ==
X-Received: by 2002:a67:c997:0:b0:3aa:1d0c:6bc7 with SMTP id y23-20020a67c997000000b003aa1d0c6bc7mr18114544vsk.16.1667484269587;
        Thu, 03 Nov 2022 07:04:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM57ejOKzdNWqeTyWHPkPRmEBqAcfUgljrJu10jVJC1iEGC5QqKTnJr+aHwKv6/RTPPoYaQADtoBOTHZ/wIpPrc=
X-Received: by 2002:a67:c997:0:b0:3aa:1d0c:6bc7 with SMTP id
 y23-20020a67c997000000b003aa1d0c6bc7mr18114480vsk.16.1667484269311; Thu, 03
 Nov 2022 07:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221102231911.3107438-1-seanjc@google.com> <20221102231911.3107438-11-seanjc@google.com>
 <d641088f-87d9-da77-7e98-92d1a9de6493@redhat.com>
In-Reply-To: <d641088f-87d9-da77-7e98-92d1a9de6493@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu, 3 Nov 2022 15:04:17 +0100
Message-ID: <CABgObfZDngVgmPetJEQGFW-MZGqYvW9tTa5jzcKheO5EO703Vw@mail.gmail.com>
Subject: Re: [PATCH 10/44] KVM: VMX: Clean up eVMCS enabling if KVM
 initialization fails
To:     Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chao Gao <chao.gao@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuan Yao <yuan.yao@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Nov 3, 2022 at 3:01 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 11/3/22 00:18, Sean Christopherson wrote:
> > +static void hv_cleanup_evmcs(void)
>
> This needs to be __init.

Error: brain temporarily disconnected.

Paolo

