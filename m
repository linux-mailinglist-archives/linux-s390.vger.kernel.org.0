Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C17A23226
	for <lists+linux-s390@lfdr.de>; Mon, 20 May 2019 13:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732630AbfETLTo (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 20 May 2019 07:19:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37783 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732629AbfETLTn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 20 May 2019 07:19:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id e15so14153761wrs.4
        for <linux-s390@vger.kernel.org>; Mon, 20 May 2019 04:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dv4xQ5o29BgVYSDlJ1uUjFnM/clLTrGgwxfVO3It7Oo=;
        b=ATRLSrxwRaqWRXq6LZiq4B3ox8wxtRDDmIr5NtBGrTc40ta8KNiGRmxYAkRnfkLQE0
         eCzXHfTxTy5Cx2D8RlIgVV/9250QH0u+UErosEpIH0V79cAmataj+T+gpSRh6nAVMOam
         Q7qtUT3rXE/9o0cWXiG4fu73SvOtSB+ChZVWAgYrb5O4c0ScU3vnjhB/e+bvYRQ1QvmZ
         b+INSK+ssWPvNxFmhuGIywsjjX0xq4vpIRAsUuxyB1SxtBaVByG5mWj93FYsxx4B9yvD
         LB3IpfcCyj8fujODoh187VxZJesnOXqx0AyKoD66U5gsW9iH4HV2o0HvzAtIsewVcO4B
         LBAA==
X-Gm-Message-State: APjAAAW0OJJcSzgR0AeQY5HRuQ7HedP/z4kJSNoY6zfZHWBNDaU0tt73
        oqmsw4Slhz+cZNF/VxeLQtPDyGPsa5Rw0A==
X-Google-Smtp-Source: APXvYqywQm13oky/RrY0xgHmzm/UUdeA3s/nxbMShVeJInIgkMS5/aQ9uuNWbjiaTAAgsw4wi2C6MA==
X-Received: by 2002:adf:e2c7:: with SMTP id d7mr9125915wrj.272.1558351182718;
        Mon, 20 May 2019 04:19:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac04:eef9:b257:b844? ([2001:b07:6468:f312:ac04:eef9:b257:b844])
        by smtp.gmail.com with ESMTPSA id a128sm15609394wma.23.2019.05.20.04.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 04:19:41 -0700 (PDT)
Subject: Re: [RFC PATCH 4/4] KVM: selftests: Add the sync_regs test for s390x
To:     Thomas Huth <thuth@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20190516111253.4494-1-thuth@redhat.com>
 <20190516111253.4494-5-thuth@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3e462f1d-c9c0-ac26-ed59-182fbbf60340@redhat.com>
Date:   Mon, 20 May 2019 13:19:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516111253.4494-5-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 16/05/19 13:12, Thomas Huth wrote:
> +#define VCPU_ID 5
> +
> +static void guest_code(void)
> +{
> +	for (;;) {
> +		asm volatile ("diag 0,0,0x501");
> +		asm volatile ("ahi 11,1");
> +	}

I'd like this to use something like

	register u32 stage = 0 asm("11");
	...
	stage++

instead (yes, it should be fixed in x86 too).

Paolo
