Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE4F692220
	for <lists+linux-s390@lfdr.de>; Fri, 10 Feb 2023 16:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjBJP12 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 10 Feb 2023 10:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjBJP11 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 10 Feb 2023 10:27:27 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA734184;
        Fri, 10 Feb 2023 07:27:25 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AEfrOa007735;
        Fri, 10 Feb 2023 15:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7iZE0NrfDz1pDVKfzMNzS5LJx98amDA3dI9THnwu5gQ=;
 b=cpV8RlrIX9oKWr/0ozGgdZ9HMBLKuhExyp++j+UlJTHb0c2IV68llEv0BhVhi3R6RZsP
 UEC7ys7QNqsLvGTOebB6bdFX3AGWcr+5ABCE4+g5BWpScIGkxMD02zuNenEgBH061rtE
 /XyICzi941HnCH5U1xVOL9wAhOYD+IbVcbLtN1Z8QXrjQcUS0FcyeWAZeAZ3PkvHCQBR
 +xUyptmX2SnmqOagMoGR5OX9EOWBFJHvwUgkozD8R60oZ1Pt88zdLEmyRsnAs+PzqSPP
 eUMW1DL3h0DXStz8bY0UjDsflQ8l7yi8GkD7IJ5AxxcmGFUn+vqXOu8pgr2DU4ecVQCA BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnqwq8wre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 15:04:05 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31AEivmX020536;
        Fri, 10 Feb 2023 15:03:43 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnqwq8v62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 15:03:43 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31ABaQeH005648;
        Fri, 10 Feb 2023 14:49:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3nhf06nf9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 14:49:21 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31AEnIOs42795354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 14:49:18 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45D8920049;
        Fri, 10 Feb 2023 14:49:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B587B20043;
        Fri, 10 Feb 2023 14:49:17 +0000 (GMT)
Received: from [9.171.75.239] (unknown [9.171.75.239])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Feb 2023 14:49:17 +0000 (GMT)
Message-ID: <3d48fd53-ffba-96c4-05e7-9e7fa457a42a@linux.ibm.com>
Date:   Fri, 10 Feb 2023 15:49:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [kvm-unit-tests PATCH v6 2/2] s390x: topology: Checking
 Configuration Topology Information
Content-Language: en-US
To:     Thomas Huth <thuth@redhat.com>, linux-s390@vger.kernel.org
Cc:     frankja@linux.ibm.com, kvm@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, nrb@linux.ibm.com, nsg@linux.ibm.com
References: <20230202092814.151081-1-pmorel@linux.ibm.com>
 <20230202092814.151081-3-pmorel@linux.ibm.com>
 <96920589-ec3c-6e2d-4eee-a12b50b5c6ca@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <96920589-ec3c-6e2d-4eee-a12b50b5c6ca@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BxYOLY2ArhFkRQLL_cRsR28CXdQ4Y7Xs
X-Proofpoint-GUID: F7js13hhcCdpsxP6DZjH3PwvaGMnnYrK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_09,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100125
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 2/8/23 12:53, Thomas Huth wrote:
> On 02/02/2023 10.28, Pierre Morel wrote:
>> STSI with function code 15 is used to store the CPU configuration
>> topology.
>>
>> We retrieve the maximum nested level with SCLP and use the
>> topology tree provided by the drawers, books, sockets, cores
>> arguments.
>>
>> We check :
>> - if the topology stored is coherent between the QEMU -smp
>>    parameters and kernel parameters.
>> - the number of CPUs
>> - the maximum number of CPUs
>> - the number of containers of each levels for every STSI(15.1.x)
>>    instruction allowed by the machine.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
> ...
>> +static inline int cpus_in_tle_mask(uint64_t val)
>> +{
>> +    int i, n;
>> +
>> +    for (i = 0, n = 0; i < 64; i++, val >>= 1)
>> +        if (val & 0x01)
>> +            n++;
>> +    return n;
> 
> I'd suggest to use __builtin_popcountl here instead of looping.

OK

> 
>> +}
>> +
>>   #endif  /* _S390X_STSI_H_ */
>> diff --git a/s390x/topology.c b/s390x/topology.c
>> index 20f7ba2..f21c653 100644
>> --- a/s390x/topology.c
>> +++ b/s390x/topology.c
>> @@ -16,6 +16,18 @@
>>   #include <smp.h>
>>   #include <sclp.h>
>>   #include <s390x/hardware.h>
>> +#include <s390x/stsi.h>
>> +
>> +static uint8_t pagebuf[PAGE_SIZE * 2] 
>> __attribute__((aligned(PAGE_SIZE * 2)));
> 
> Isn't the SYSIB just one page only? Why reserve two pages here?

Yes it is, I change it to a single page.

> 
>> +static int max_nested_lvl;
>> +static int number_of_cpus;
>> +static int max_cpus = 1;
>> +
>> +/* Topology level as defined by architecture */
>> +static int arch_topo_lvl[CPU_TOPOLOGY_MAX_LEVEL];
>> +/* Topology nested level as reported in STSI */
>> +static int stsi_nested_lvl[CPU_TOPOLOGY_MAX_LEVEL];
>>   #define PTF_REQ_HORIZONTAL    0
>>   #define PTF_REQ_VERTICAL    1
>> @@ -122,11 +134,241 @@ end:
>>       report_prefix_pop();
>>   }
>> +/*
>> + * stsi_check_maxcpus
>> + * @info: Pointer to the stsi information
>> + *
>> + * The product of the numbers of containers per level
>> + * is the maximum number of CPU allowed by the machine.
>> + */
>> +static void stsi_check_maxcpus(struct sysinfo_15_1_x *info)
>> +{
>> +    int n, i;
>> +
>> +    report_prefix_push("maximum cpus");
>> +
>> +    for (i = 0, n = 1; i < CPU_TOPOLOGY_MAX_LEVEL; i++) {
>> +        report_info("Mag%d: %d", CPU_TOPOLOGY_MAX_LEVEL - i, 
>> info->mag[i]);
>> +        n *= info->mag[i] ? info->mag[i] : 1;
> 
> You could use the Elvis operator here instead.

Right thanks.


> 
>> +    }
>> +    report(n == max_cpus, "Maximum CPUs %d expected %d", n, max_cpus);
>> +
>> +    report_prefix_pop();
>> +}
>> +
>> +/*
>> + * stsi_check_tle_coherency
>> + * @info: Pointer to the stsi information
>> + * @sel2: Topology level to check.
>> + *
>> + * We verify that we get the expected number of Topology List Entry
>> + * containers for a specific level.
>> + */
>> +static void stsi_check_tle_coherency(struct sysinfo_15_1_x *info, int 
>> sel2)
>> +{
>> +    struct topology_container *tc, *end;
>> +    struct topology_core *cpus;
>> +    int n = 0;
>> +    int i;
>> +
>> +    report_prefix_push("TLE coherency");
>> +
>> +    tc = &info->tle[0].container;
>> +    end = (struct topology_container *)((unsigned long)info + 
>> info->length);
> 
> s/unsigned long/uintptr_t/ please!

OK, thanks

> 
> 
>> +
>> +    for (i = 0; i < CPU_TOPOLOGY_MAX_LEVEL; i++)
>> +        stsi_nested_lvl[i] = 0;
> 
> memset(stsi_nested_lvl, 0, sizeof(stsi_nested_lvl)) ?

better, thanks

> 
>> +    while (tc < end) {
>> +        if (tc->nl > 5) {
> 
> Use ">= CPU_TOPOLOGY_MAX_LEVEL" instead of "> 5" ?

OK

> 
>> +            report_abort("Unexpected TL Entry: tle->nl: %d", tc->nl);
>> +            return;
>> +        }
>> +        if (tc->nl == 0) {
>> +            cpus = (struct topology_core *)tc;
>> +            n += cpus_in_tle_mask(cpus->mask);
>> +            report_info("cpu type %02x  d: %d pp: %d", cpus->type, 
>> cpus->d, cpus->pp);
>> +            report_info("origin : %04x mask %016lx", cpus->origin, 
>> cpus->mask);
>> +        }
>> +
>> +        stsi_nested_lvl[tc->nl]++;
>> +        report_info("level %d: lvl: %d id: %d cnt: %d",
>> +                tc->nl, tc->nl, tc->id, stsi_nested_lvl[tc->nl]);
>> +
>> +        /* trick: CPU TLEs are twice the size of containers TLE */
>> +        if (tc->nl == 0)
>> +            tc++;
> 
> IMHO it might be cleaner to have a "uint8_t *" or "void *" to the 
> current position in the sysinfo block, and do the pointer arithmetic on 
> that pointer instead... well, it's likely just a matter of taste.

OK

> 
>> +        tc++;
>> +    }
>> +    report(n == number_of_cpus, "Number of CPUs  : %d expect %d", n, 
>> number_of_cpus);
>> +    /*
>> +     * For KVM we accept
>> +     * - only 1 type of CPU
>> +     * - only horizontal topology
>> +     * - only dedicated CPUs
>> +     * This leads to expect the number of entries of level 0 CPU
>> +     * Topology Level Entry (TLE) to be:
>> +     * 1 + (number_of_cpus - 1)  / arch_topo_lvl[0]
>> +     *
>> +     * For z/VM or LPAR this number can only be greater if different
>> +     * polarity, CPU types because there may be a nested level 0 CPU TLE
>> +     * for each of the CPU/polarity/sharing types in a level 1 
>> container TLE.
>> +     */
>> +    n =  (number_of_cpus - 1)  / arch_topo_lvl[0];
>> +    report(stsi_nested_lvl[0] >=  n + 1,
>> +           "CPU Type TLE    : %d expect %d", stsi_nested_lvl[0], n + 1);
>> +
>> +    /* For each level found in STSI */
>> +    for (i = 1; i < CPU_TOPOLOGY_MAX_LEVEL; i++) {
>> +        /*
>> +         * For non QEMU/KVM hypervisor the concatenation of the levels
>> +         * above level 1 are architecture dependent.
>> +         * Skip these checks.
>> +         */
>> +        if (!host_is_kvm() && sel2 != 2)
>> +            continue;
>> +
>> +        /* For QEMU/KVM we expect a simple calculation */
>> +        if (sel2 > i) {
>> +            report(stsi_nested_lvl[i] ==  n + 1,
>> +                   "Container TLE  %d: %d expect %d", i, 
>> stsi_nested_lvl[i], n + 1);
>> +            n /= arch_topo_lvl[i];
>> +        }
>> +    }
>> +
>> +    report_prefix_pop();
>> +}
>> +
>> +/*
>> + * check_sysinfo_15_1_x
>> + * @info: pointer to the STSI info structure
>> + * @sel2: the selector giving the topology level to check
>> + *
>> + * Check if the validity of the STSI instruction and then
>> + * calls specific checks on the information buffer.
>> + */
>> +static void check_sysinfo_15_1_x(struct sysinfo_15_1_x *info, int sel2)
>> +{
>> +    int ret;
>> +
>> +    report_prefix_pushf("mnested %d 15_1_%d", max_nested_lvl, sel2);
>> +
>> +    ret = stsi(pagebuf, 15, 1, sel2);
>> +    if (max_nested_lvl >= sel2) {
>> +        report(!ret, "Valid stsi instruction");
>> +    } else {
>> +        report(ret, "Invalid stsi instruction");
>> +        goto end;
>> +    }
>> +
>> +    stsi_check_maxcpus(info);
>> +    stsi_check_tle_coherency(info, sel2);
> 
> You could also move the two stsi_check_* calls into the first part of 
> the if-statement, then you could get rid of the goto in the second part.

Thanks, yes.

> 
>> +end:
>> +    report_prefix_pop();
>> +}
>> +
>> +static int sclp_get_mnest(void)
>> +{
>> +    ReadInfo *sccb = (void *)_sccb;
>> +
>> +    sclp_mark_busy();
>> +    memset(_sccb, 0, PAGE_SIZE);
>> +    sccb->h.length = PAGE_SIZE;
>> +
>> +    sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb);
>> +    assert(sccb->h.response_code == SCLP_RC_NORMAL_READ_COMPLETION);
>> +
>> +    return sccb->stsi_parm;
>> +}
>> +
>> +/*
>> + * test_stsi
>> + *
>> + * Retrieves the maximum nested topology level supported by the 
>> architecture
>> + * and the number of CPUs.
>> + * Calls the checking for the STSI instruction in sel2 reverse level 
>> order
>> + * from 6 (CPU_TOPOLOGY_MAX_LEVEL) to 2 to have the most interesting 
>> level,
>> + * the one triggering a topology-change-report-pending condition, 
>> level 2,
>> + * at the end of the report.
>> + *
>> + */
>> +static void test_stsi(void)
>> +{
>> +    int sel2;
>> +
>> +    max_nested_lvl = sclp_get_mnest();
>> +    report_info("SCLP maximum nested level : %d", max_nested_lvl);
>> +
>> +    number_of_cpus = sclp_get_cpu_num();
>> +    report_info("SCLP number of CPU: %d", number_of_cpus);
>> +
>> +    /* STSI selector 2 can takes values between 2 and 6 */
>> +    for (sel2 = 6; sel2 >= 2; sel2--)
>> +        check_sysinfo_15_1_x((struct sysinfo_15_1_x *)pagebuf, sel2);
>> +}
>> +
>> +/*
>> + * parse_topology_args
>> + * @argc: number of arguments
>> + * @argv: argument array
>> + *
>> + * This function initialize the architecture topology levels
>> + * which should be the same as the one provided by the hypervisor.
>> + *
>> + * We use the current names found in IBM/Z literature, Linux and QEMU:
>> + * cores, sockets/packages, books, drawers and nodes to facilitate the
>> + * human machine interface but store the result in a machine abstract
>> + * array of architecture topology levels.
>> + * Note that when QEMU uses socket as a name for the topology level 1
>> + * Linux uses package or physical_package.
>> + */
>> +static void parse_topology_args(int argc, char **argv)
>> +{
>> +    int i;
>> +
>> +    report_info("%d arguments", argc);
>> +    for (i = 1; i < argc; i++) {
>> +        if (!strcmp("-cores", argv[i])) {
>> +            i++;
>> +            if (i >= argc)
>> +                report_abort("-cores needs a parameter");
>> +            arch_topo_lvl[0] = atol(argv[i]);
>> +            report_info("cores: %d", arch_topo_lvl[0]);
>> +        } else if (!strcmp("-sockets", argv[i])) {
>> +            i++;
>> +            if (i >= argc)
>> +                report_abort("-sockets needs a parameter");
>> +            arch_topo_lvl[1] = atol(argv[i]);
>> +            report_info("sockets: %d", arch_topo_lvl[1]);
>> +        } else if (!strcmp("-books", argv[i])) {
>> +            i++;
>> +            if (i >= argc)
>> +                report_abort("-books needs a parameter");
>> +            arch_topo_lvl[2] = atol(argv[i]);
>> +            report_info("books: %d", arch_topo_lvl[2]);
>> +        } else if (!strcmp("-drawers", argv[i])) {
>> +            i++;
>> +            if (i >= argc)
>> +                report_abort("-drawers needs a parameter");
>> +            arch_topo_lvl[3] = atol(argv[i]);
>> +            report_info("drawers: %d", arch_topo_lvl[3]);
>> +        }
> 
> Maybe abort on unkown parameters, to avoid that typos go unnoticed?

Yes, better.
Thanks,

Regards.
Pierre


-- 
Pierre Morel
IBM Lab Boeblingen
