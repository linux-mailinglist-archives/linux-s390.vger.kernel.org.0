Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6498C2226E3
	for <lists+linux-s390@lfdr.de>; Thu, 16 Jul 2020 17:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgGPPXL (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 16 Jul 2020 11:23:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59837 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729168AbgGPPXK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Jul 2020 11:23:10 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1jw5j3-0003HT-12
        for linux-s390@vger.kernel.org; Thu, 16 Jul 2020 15:23:09 +0000
Received: by mail-il1-f197.google.com with SMTP id w10so3910807ilm.16
        for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2020 08:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=1/qolDFvhpKVU/laUVqhlu2vl5yv7xqj8R5RCMHuoAE=;
        b=e22Z1/L5RWA+YV2IWzi0kRNf2AdGqwhp/ys6lhmSqyo4bNuM5AcP41PQu9Av362Ix4
         Qtf5ZCxZHsPPN1mC4KwaBSEZgIuGuP1a8CduXHS0KVPs1aQdoGaI//N54vRV0kqxoWnO
         qd7Q+b9qcbCqoVtCYjzZgkFfWw22oofS6Icpg9ZKecUFTSdFaEloaQmtzkWrwkA0CST4
         0AT795g+OQMhEc1KbJWRl0lj3I83ciYpDZ+BOtiuaVpB9gEcnOglVXdwqqrHrQ8RpLlI
         04iIHssQ/tyXwJ0T0z9PqTyr2PtLhyOwckosMMFYlg+BJsaORFxm5pOqAy0aNsQpCzsp
         yEWg==
X-Gm-Message-State: AOAM533hsuM3jR6hTnWlMsn/BMYKcA2SE2KMYnFq+55GQ7bW3XKYQiCs
        BHsPtoPEZRG5KpoMyIcRD9+k3GwOup7O6aV2Lim/TBBQxzu7sOjMLkMW7EGH342IM/rKdAFU1QO
        1AkEqKwdSjHOBWjqOS5X71NUyABiXRWvL4Eqj9i8=
X-Received: by 2002:a92:9144:: with SMTP id t65mr4972487ild.157.1594912987980;
        Thu, 16 Jul 2020 08:23:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrcNPFqPdPzXrKIfmDcBgzmn7KYvCBmjSXDPrxbfaGjS57nLBMFDU5BF5DLJu0FIUjZaBEMA==
X-Received: by 2002:a92:9144:: with SMTP id t65mr4972471ild.157.1594912987705;
        Thu, 16 Jul 2020 08:23:07 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:90fa:132a:bf3e:99a1])
        by smtp.gmail.com with ESMTPSA id o67sm2764824ila.25.2020.07.16.08.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 08:23:07 -0700 (PDT)
Date:   Thu, 16 Jul 2020 10:23:06 -0500
From:   seth.forshee@canonical.com
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: test_bpf regressions on s390 since 5.4
Message-ID: <20200716152306.GH3644@ubuntu-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The tests in lib/test_bpf.c were all passing in 5.4 when using the JIT,
but some are failing in 5.7/5.8. Some of the failures are due to the
removal of BPF_SIZE_MAX causing some expected failures to pass, which I
have already send a patch for [1]. The remaining failures appear to be
regressions. I haven't tried 5.5 or 5.6, so I'm not sure exactly when
they first appeared.

These are the tests which currently fail:

 test_bpf: #37 INT: MUL_X jited:1 ret -1 != 1 FAIL (1 times)
 test_bpf: #42 INT: SUB jited:1 ret -55 != 11 FAIL (1 times)
 test_bpf: #44 INT: MUL jited:1 ret 439084800 != 903446258 FAIL (1 times)
 test_bpf: #49 INT: shifts by register jited:1 ret -617 != -1 FAIL (1 times)
 test_bpf: #371 JNE signed compare, test 1 jited:1 ret 2 != 1 FAIL (1 times)
 test_bpf: #372 JNE signed compare, test 2 jited:1 ret 2 != 1 FAIL (1 times)
 test_bpf: #374 JNE signed compare, test 4 jited:1 ret 1 != 2 FAIL (1 times)
 test_bpf: #375 JNE signed compare, test 5 jited:1 ret 2 != 1 FAIL (1 times)

Thanks,
Seth

[1] https://lore.kernel.org/lkml/20200716143931.330122-1-seth.forshee@canonical.com/
