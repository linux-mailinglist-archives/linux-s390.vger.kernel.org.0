Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91DADB00E8
	for <lists+linux-s390@lfdr.de>; Wed, 11 Sep 2019 18:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbfIKQGs (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 11 Sep 2019 12:06:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728921AbfIKQGs (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Sep 2019 12:06:48 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C31F3D966
        for <linux-s390@vger.kernel.org>; Wed, 11 Sep 2019 16:06:48 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id j2so2453898wre.1
        for <linux-s390@vger.kernel.org>; Wed, 11 Sep 2019 09:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uO053ChcA2C5+3QS5EI/icsqMGzSyFtb1MyaVKVNsOE=;
        b=KJaK8TQUJfd3BeFBpp4WkRosEVfAExsO37fem/XaEymiw7RBM/K0QaxnhhGJDoYKmR
         SxZ6NiPX2ydW1bDRpkO9bZwqfRRSP5xdvJ99IbCDQObcHbz44N/BWMqayZcbdSAqcfyv
         Aitpo5T/puJ1EY5aZnxAcNSDaQB3diwnDU2uGaL77LupusFDtwo+Dk99N2U4j3JtkWMt
         MX6VhC/cBWCCQJbg+pGS84StRamQbt3ttxiY4FzSuu0l+yTUXtgkEq3vtdgEGNSTelc4
         gGdRHao6N5viLWORat4eiTYEcSl1vOevuUdPZpV5PFbA+5F2i6J907oJ13s3lgDHROLL
         OgIA==
X-Gm-Message-State: APjAAAVsfp3H2bWy0oM8qcdIzKpK6yRRo4F+3ToeplH98bcl6ySfhdei
        CvFPtzcDRJD1MPGc26UUsrMgDK8OOeS0+FETflC72SEi8K0jNBt6aLMjzIXEkvUOhwKlJK+xw3C
        1yvnFDcobIAvBMF1oJqgPtQ==
X-Received: by 2002:adf:de8b:: with SMTP id w11mr3814001wrl.289.1568218006652;
        Wed, 11 Sep 2019 09:06:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzyDutA8/SQ5xDAxvuoDWUoFeK4t3HnXaXS3EdtVC0nGgyM5yZ1MN1PF8PuvUdV/QQznRuu+Q==
X-Received: by 2002:adf:de8b:: with SMTP id w11mr3813979wrl.289.1568218006429;
        Wed, 11 Sep 2019 09:06:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:102b:3795:6714:7df6? ([2001:b07:6468:f312:102b:3795:6714:7df6])
        by smtp.gmail.com with ESMTPSA id s12sm12857889wrn.90.2019.09.11.09.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2019 09:06:45 -0700 (PDT)
Subject: Re: [GIT PULL 0/8] KVM: s390: extend selftests add more input checks
To:     Janosch Frank <frankja@linux.ibm.com>, rkrcmar@redhat.com
Cc:     kvm@vger.kernel.org, cohuck@redhat.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, frankja@linux.vnet.ibm.com,
        david@redhat.com, thuth@redhat.com
References: <20190905084009.26106-1-frankja@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a4756c8c-6d1a-1006-206f-fe23efda996e@redhat.com>
Date:   Wed, 11 Sep 2019 18:06:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905084009.26106-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 05/09/19 10:40, Janosch Frank wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-next-5.4-1

Pulled, thanks.

Paolo
